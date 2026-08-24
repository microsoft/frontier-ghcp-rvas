import { Pressable, StyleSheet, Text, View } from "react-native";
import type { TechnicianJob } from "../domain/types";

interface Props {
  job: TechnicianJob;
  selected: boolean;
  onPress: () => void;
}

export function JobCard({ job, selected, onPress }: Props) {
  return (
    <Pressable
      onPress={onPress}
      style={[styles.card, selected && styles.selected]}
    >
      <View style={styles.row}>
        <Text style={styles.id}>{job.id}</Text>
        <Text style={styles.status}>{job.status.toUpperCase()}</Text>
      </View>
      <Text style={styles.asset}>{job.assetLabel}</Text>
      <Text style={styles.customer}>{job.customerName}</Text>
      <Text style={styles.address}>{job.address}</Text>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  card: {
    backgroundColor: "#ffffff",
    borderColor: "#c8ccd2",
    borderLeftColor: "#ffcc33",
    borderLeftWidth: 7,
    borderRadius: 4,
    borderWidth: 1,
    gap: 4,
    padding: 16
  },
  selected: {
    borderColor: "#11253d",
    shadowColor: "#11253d",
    shadowOffset: { width: 3, height: 3 },
    shadowOpacity: 1,
    shadowRadius: 0
  },
  row: {
    alignItems: "center",
    flexDirection: "row",
    justifyContent: "space-between"
  },
  id: { color: "#516173", fontSize: 12, fontWeight: "800", letterSpacing: 1 },
  status: {
    backgroundColor: "#e7edf2",
    color: "#11253d",
    fontSize: 10,
    fontWeight: "900",
    paddingHorizontal: 7,
    paddingVertical: 4
  },
  asset: { color: "#11253d", fontSize: 18, fontWeight: "900" },
  customer: { color: "#33465c", fontSize: 14, fontWeight: "700" },
  address: { color: "#667485", fontSize: 13 }
});
