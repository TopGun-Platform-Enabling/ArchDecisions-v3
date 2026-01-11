import pandas as pd
import os
from datetime import datetime
from dataclasses import dataclass

# Target directory
TARGET_DIR = "./allure-report"

# Expected schema definitions
expected_columns = {
    "COVID19BE_CASES": ["DATE", "REGION", "AGEGROUP", "SEX", "CASES"],
    "COVID19BE_DEATHS": ["DATE", "REGION", "AGEGROUP", "SEX", "DEATHS"],
    "COVID19BE_HOSP": ["DATE", "REGION", "NR_REPORTING", "TOTAL_IN", "TOTAL_OUT", "TOTAL_INT"],
    "COVID19BE_TESTS": ["DATE", "REGION", "TESTS_ALL", "TESTS_POS"],
    "COVID19BE_VACC": ["DATE", "REGION", "AGEGROUP", "SEX", "DOSE", "COUNT"]
}

# Benchmark results
results = []

for name, cols in expected_columns.items():
    file_path = os.path.join(TARGET_DIR, f"{name}.csv")
    if not os.path.exists(file_path):
        results.append((name, "❌ Missing file", None, None))
        continue

    try:
        df = pd.read_csv(file_path)

        missing_cols = [c for c in cols if c not in df.columns]
        extra_cols = [c for c in df.columns if c not in cols]

        compliant = len(missing_cols) == 0
        row_count = len(df)

        if "DATE" in df.columns:
            df["DATE"] = pd.to_datetime(df["DATE"], errors="coerce")
            max_date = df["DATE"].max()
            age_days = (datetime.now() - max_date).days if pd.notnull(max_date) else None
        else:
            max_date, age_days = None, None

        results.append((
            name,
            "✅ Compliant" if compliant else f"⚠️ Missing {missing_cols}, Extra {extra_cols}",
            row_count,
            f"Last date {max_date}, {age_days} days old" if max_date is not None else "No DATE column"
        ))

    except Exception as e:
        results.append((name, f"❌ Error {e}", None, None))

# Print benchmark table
print("Dataset, Compliance, Rows, Freshness")
for r in results:
    print(",".join([str(x) for x in r]))


# -------------------------
# TESTING SECTION (pytest)
# -------------------------

def add(result_tuple):
    """Return the benchmark tuple unchanged."""
    return result_tuple


def test_datalz22():
    """Test that missing files are detected."""
    for r in results:
        dataset, status, expected, actual = add(r)
        if status == "❌ Missing file":
            assert expected is None
            assert actual is None


def test_row_count():
    """Test that row count is consistent for existing datasets."""
    for r in results:
        dataset, status, expected_rows, freshness = r
        if status.startswith("✅"):
            assert expected_rows is not None
            assert expected_rows >= 0
