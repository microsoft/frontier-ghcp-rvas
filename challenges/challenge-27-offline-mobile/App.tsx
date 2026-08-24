import { useEffect, useMemo, useReducer } from "react";
import {
  Alert,
  Pressable,
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  View
} from "react-native";
import { InspectionPanel } from "./src/components/InspectionPanel";
import { JobCard } from "./src/components/JobCard";
import type {
  InspectionDraft,
  NetworkFixture,
  OfflineAction,
  TechnicianJob
} from "./src/domain/types";
import jobsFixture from "./src/fixtures/jobs.json";
import networkFixtures from "./src/fixtures/network.json";
import { permissionGateway } from "./src/platform/permissions";
import { AzureFunctionsClient } from "./src/services/azureFunctionsClient";
import { appReducer, type AppState } from "./src/state/appReducer";
import { localStore } from "./src/storage/localStore";
import { flushQueue } from "./src/sync/offlineQueue";

const networks = networkFixtures as NetworkFixture[];
const initialNetwork = networks[0]!;

const initialState: AppState = {
  jobs: [],
  drafts: {},
  queue: [],
  conflicts: [],
  network: initialNetwork,
  loading: true
};

export default function App() {
  const [state, dispatch] = useReducer(appReducer, initialState);
  const selectedJob = state.jobs.find(
    (job) => job.id === state.selectedJobId
  );
  const client = useMemo(
    () => new AzureFunctionsClient(state.network),
    [state.network]
  );

  useEffect(() => {
    localStore.load().then((snapshot) => {
      dispatch({
        type: "jobs-loaded",
        jobs: snapshot?.jobs ?? (jobsFixture as TechnicianJob[])
      });
    });
  }, []);

  useEffect(() => {
    localStore.save({
      jobs: state.jobs,
      drafts: state.drafts,
      queue: state.queue
    });
  }, [state.jobs, state.drafts, state.queue]);

  const saveDraft = (draft: InspectionDraft) => {
    const job = state.jobs.find((item) => item.id === draft.jobId);
    if (!job) return;

    const action: OfflineAction = {
      id: `action-${Date.now()}`,
      type: "save-inspection",
      jobId: draft.jobId,
      baseVersion: job.serverVersion,
      createdAt: new Date().toISOString(),
      payload: draft
    };
    dispatch({ type: "draft-saved", draft, action });
  };

  const synchronize = async () => {
    const result = await flushQueue(state.queue, client);
    dispatch({
      type: "sync-finished",
      remaining: result.remaining,
      conflicts: result.conflicts,
      syncedCount: result.syncedActionIds.length
    });
  };

  const requestPermission = async (kind: "camera" | "location") => {
    const result =
      kind === "camera"
        ? await permissionGateway.requestCamera()
        : await permissionGateway.requestLocation();
    Alert.alert(`${kind} permission`, `Current starter result: ${result}`);
  };

  return (
    <SafeAreaView style={styles.safe}>
      <StatusBar barStyle="light-content" />
      <ScrollView contentContainerStyle={styles.page}>
        <View style={styles.header}>
          <View>
            <Text style={styles.kicker}>FIELD NOTES / ROUTE 06</Text>
            <Text style={styles.title}>Friday service board</Text>
          </View>
          <View style={styles.queueBadge}>
            <Text style={styles.queueNumber}>{state.queue.length}</Text>
            <Text style={styles.queueLabel}>QUEUED</Text>
          </View>
        </View>

        <View style={styles.networkStrip}>
          <Text style={styles.networkLabel}>NETWORK FIXTURE</Text>
          <ScrollView horizontal showsHorizontalScrollIndicator={false}>
            <View style={styles.networkChoices}>
              {networks.map((network) => (
                <Pressable
                  key={network.id}
                  onPress={() =>
                    dispatch({ type: "network-changed", network })
                  }
                  style={[
                    styles.networkButton,
                    state.network.id === network.id && styles.networkActive
                  ]}
                >
                  <Text style={styles.networkText}>{network.label}</Text>
                </Pressable>
              ))}
            </View>
          </ScrollView>
        </View>

        {state.message ? <Text style={styles.message}>{state.message}</Text> : null}
        {state.conflicts.length > 0 ? (
          <Text style={styles.conflict}>
            {state.conflicts.length} synchronization conflict(s) need a policy.
          </Text>
        ) : null}

        <View style={styles.layout}>
          <View style={styles.jobs}>
            <View style={styles.sectionHeader}>
              <Text style={styles.sectionTitle}>Today&apos;s jobs</Text>
              <Text style={styles.count}>{state.jobs.length} stops</Text>
            </View>
            {state.jobs.map((job) => (
              <JobCard
                job={job}
                key={job.id}
                onPress={() =>
                  dispatch({ type: "job-selected", jobId: job.id })
                }
                selected={state.selectedJobId === job.id}
              />
            ))}
          </View>

          <View style={styles.inspection}>
            {selectedJob ? (
              <InspectionPanel
                draft={state.drafts[selectedJob.id]}
                job={selectedJob}
                onCamera={() => requestPermission("camera")}
                onLocation={() => requestPermission("location")}
                onSave={saveDraft}
              />
            ) : (
              <View style={styles.empty}>
                <Text style={styles.emptyNumber}>01</Text>
                <Text style={styles.emptyTitle}>Pick a job to inspect</Text>
                <Text style={styles.emptyCopy}>
                  The starter keeps work only for this browser session. Refresh
                  the page to see the persistence gap.
                </Text>
              </View>
            )}
            <Pressable
              disabled={state.queue.length === 0}
              onPress={synchronize}
              style={[
                styles.syncButton,
                state.queue.length === 0 && styles.syncDisabled
              ]}
            >
              <Text style={styles.syncText}>Synchronize queued work</Text>
            </Pressable>
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safe: { backgroundColor: "#11253d", flex: 1 },
  page: { backgroundColor: "#e8e5dc", flexGrow: 1, paddingBottom: 40 },
  header: {
    alignItems: "center",
    backgroundColor: "#11253d",
    flexDirection: "row",
    justifyContent: "space-between",
    padding: 22
  },
  kicker: { color: "#ffcc33", fontSize: 11, fontWeight: "900", letterSpacing: 2 },
  title: { color: "#ffffff", fontSize: 27, fontWeight: "900", marginTop: 4 },
  queueBadge: {
    alignItems: "center",
    backgroundColor: "#ffcc33",
    minWidth: 66,
    padding: 8
  },
  queueNumber: { color: "#11253d", fontSize: 22, fontWeight: "900" },
  queueLabel: { color: "#11253d", fontSize: 9, fontWeight: "900", letterSpacing: 1 },
  networkStrip: {
    backgroundColor: "#d7d4ca",
    borderBottomColor: "#b4b1a8",
    borderBottomWidth: 1,
    gap: 8,
    padding: 12
  },
  networkLabel: { color: "#516173", fontSize: 10, fontWeight: "900", letterSpacing: 1.5 },
  networkChoices: { flexDirection: "row", gap: 7 },
  networkButton: {
    backgroundColor: "#ffffff",
    borderColor: "#8994a1",
    borderWidth: 1,
    paddingHorizontal: 10,
    paddingVertical: 7
  },
  networkActive: { backgroundColor: "#ffcc33", borderColor: "#11253d" },
  networkText: { color: "#11253d", fontSize: 12, fontWeight: "800" },
  message: {
    backgroundColor: "#dcebd9",
    color: "#214e26",
    fontWeight: "800",
    padding: 12
  },
  conflict: {
    backgroundColor: "#f3d4cd",
    color: "#7a251b",
    fontWeight: "900",
    padding: 12
  },
  layout: { gap: 18, padding: 18 },
  jobs: { gap: 10 },
  sectionHeader: {
    alignItems: "baseline",
    flexDirection: "row",
    justifyContent: "space-between"
  },
  sectionTitle: { color: "#11253d", fontSize: 20, fontWeight: "900" },
  count: { color: "#667485", fontSize: 12, fontWeight: "700" },
  inspection: { gap: 12 },
  empty: {
    backgroundColor: "#f7f4ea",
    borderColor: "#11253d",
    borderStyle: "dashed",
    borderWidth: 2,
    padding: 22
  },
  emptyNumber: { color: "#ffcc33", fontSize: 44, fontWeight: "900" },
  emptyTitle: { color: "#11253d", fontSize: 22, fontWeight: "900" },
  emptyCopy: { color: "#516173", lineHeight: 21, marginTop: 8 },
  syncButton: { backgroundColor: "#ad3e2d", padding: 15 },
  syncDisabled: { backgroundColor: "#8994a1" },
  syncText: { color: "#ffffff", fontWeight: "900", textAlign: "center" }
});
