import { useEffect, useState } from "react";
import {
  Pressable,
  StyleSheet,
  Text,
  TextInput,
  View
} from "react-native";
import type {
  InspectionDraft,
  InspectionResult,
  TechnicianJob
} from "../domain/types";

interface Props {
  job: TechnicianJob;
  draft?: InspectionDraft;
  onSave: (draft: InspectionDraft) => void;
  onCamera: () => void;
  onLocation: () => void;
}

export function InspectionPanel({
  job,
  draft,
  onSave,
  onCamera,
  onLocation
}: Props) {
  const [result, setResult] = useState<InspectionResult | undefined>(
    draft?.result
  );
  const [meterReading, setMeterReading] = useState(draft?.meterReading ?? "");
  const [notes, setNotes] = useState(draft?.notes ?? "");

  useEffect(() => {
    setResult(draft?.result);
    setMeterReading(draft?.meterReading ?? "");
    setNotes(draft?.notes ?? "");
  }, [draft, job.id]);

  const save = () =>
    onSave({
      jobId: job.id,
      result,
      meterReading,
      notes,
      updatedAt: new Date().toISOString()
    });

  return (
    <View style={styles.panel}>
      <Text style={styles.eyebrow}>ACTIVE INSPECTION</Text>
      <Text style={styles.heading}>{job.assetLabel}</Text>
      <Text style={styles.prompt}>Condition</Text>
      <View style={styles.resultRow}>
        {(["pass", "repair-needed"] as const).map((value) => (
          <Pressable
            key={value}
            onPress={() => setResult(value)}
            style={[styles.choice, result === value && styles.choiceActive]}
          >
            <Text style={styles.choiceText}>
              {value === "pass" ? "Pass" : "Repair needed"}
            </Text>
          </Pressable>
        ))}
      </View>
      <Text style={styles.prompt}>Meter reading</Text>
      <TextInput
        keyboardType="decimal-pad"
        onChangeText={setMeterReading}
        placeholder="Enter reading"
        style={styles.input}
        value={meterReading}
      />
      <Text style={styles.prompt}>Technician notes</Text>
      <TextInput
        multiline
        onChangeText={setNotes}
        placeholder="What did you find?"
        style={[styles.input, styles.notes]}
        value={notes}
      />
      <View style={styles.tools}>
        <Pressable onPress={onCamera} style={styles.toolButton}>
          <Text style={styles.toolText}>Attach photo</Text>
        </Pressable>
        <Pressable onPress={onLocation} style={styles.toolButton}>
          <Text style={styles.toolText}>Add location</Text>
        </Pressable>
      </View>
      <Pressable onPress={save} style={styles.saveButton}>
        <Text style={styles.saveText}>Save inspection offline</Text>
      </Pressable>
    </View>
  );
}

const styles = StyleSheet.create({
  panel: {
    backgroundColor: "#f7f4ea",
    borderColor: "#11253d",
    borderRadius: 4,
    borderWidth: 2,
    gap: 10,
    padding: 18
  },
  eyebrow: { color: "#ad3e2d", fontSize: 11, fontWeight: "900", letterSpacing: 2 },
  heading: { color: "#11253d", fontSize: 24, fontWeight: "900" },
  prompt: { color: "#11253d", fontSize: 13, fontWeight: "800", marginTop: 4 },
  resultRow: { flexDirection: "row", gap: 8 },
  choice: {
    backgroundColor: "#ffffff",
    borderColor: "#8994a1",
    borderWidth: 1,
    paddingHorizontal: 13,
    paddingVertical: 10
  },
  choiceActive: { backgroundColor: "#ffcc33", borderColor: "#11253d" },
  choiceText: { color: "#11253d", fontWeight: "800" },
  input: {
    backgroundColor: "#ffffff",
    borderColor: "#8994a1",
    borderWidth: 1,
    color: "#11253d",
    fontSize: 16,
    padding: 12
  },
  notes: { minHeight: 88, textAlignVertical: "top" },
  tools: { flexDirection: "row", gap: 8 },
  toolButton: {
    borderColor: "#11253d",
    borderWidth: 1,
    flex: 1,
    padding: 10
  },
  toolText: { color: "#11253d", fontSize: 12, fontWeight: "800", textAlign: "center" },
  saveButton: { backgroundColor: "#11253d", marginTop: 4, padding: 14 },
  saveText: { color: "#ffffff", fontSize: 15, fontWeight: "900", textAlign: "center" }
});
