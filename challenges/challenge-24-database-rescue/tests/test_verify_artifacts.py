import importlib.util
import unittest
from pathlib import Path


MODULE_PATH = Path(__file__).resolve().parents[1] / "tools" / "verify_artifacts.py"
SPEC = importlib.util.spec_from_file_location("verify_artifacts", MODULE_PATH)
VERIFY = importlib.util.module_from_spec(SPEC)
assert SPEC.loader is not None
SPEC.loader.exec_module(VERIFY)


class VerifyArtifactsTests(unittest.TestCase):
    def test_query_id_parser_ignores_unrelated_labels(self):
        text = "-- Query ID: Q1\n-- Query ID: Q4\n-- Query ID: Q9"
        self.assertEqual(VERIFY.query_ids(text), {"Q1", "Q4"})

    def test_starter_contract_is_internally_consistent(self):
        checks = VERIFY.verify_starter()
        self.assertIn("transactional schema", checks)
        self.assertIn("evidence fixtures", checks)

    def test_submission_mode_rejects_starter_placeholders(self):
        with self.assertRaises(VERIFY.VerificationError):
            VERIFY.verify_submission()


if __name__ == "__main__":
    unittest.main()
