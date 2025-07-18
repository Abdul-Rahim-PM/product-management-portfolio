```sql
-- Anaplan Models for Financial Planning - SQL Queries
-- Abdul Rahim, June 2025
-- Queries to validate data for Anaplan models, integrated via IICS from SAP ERP

-- Query 1: Validate Budget Data
SELECT budget_id, department, amount, fiscal_year
FROM sap_budget
WHERE fiscal_year = 2025
AND amount > 0
ORDER BY department;
-- Purpose: Ensure budget data aligns with Anaplan Budgeting Model
-- Expected: Matches Anaplan data, no nulls

-- Query 2: Check Forecast Accuracy
SELECT forecast_id, region, projected_revenue, actual_revenue
FROM sap_forecast
WHERE forecast_date BETWEEN '2025-01-01' AND '2025-06-30'
AND ABS(projected_revenue - actual_revenue) / actual_revenue <= 0.05;
-- Purpose: Validate forecasting model accuracy within 5%
-- Expected: >95% of records within threshold

-- Query 3: Verify Revenue Data Sync
SELECT transaction_id, product, revenue, sync_date
FROM sap_revenue
WHERE sync_date >= '2025-06-01'
AND product IS NOT NULL;
-- Purpose: Confirm IICS sync for Revenue Model
-- Expected: All records synced, no missing products

-- Query 4: Validate Workforce Data
SELECT employee_id, department, role, hire_date
FROM sap_workforce
WHERE hire_date >= '2025-01-01'
AND role IN ('Analyst', 'Manager');
-- Purpose: Ensure workforce data for Workforce Model
-- Expected: Matches Anaplan headcount data

-- Query 5: Check Expense Overruns
SELECT expense_id, category, amount, budget_limit
FROM sap_expenses
WHERE amount > budget_limit
AND fiscal_year = 2025;
-- Purpose: Flag overruns for Expense Model
-- Expected: Alerts triggered in Anaplan
```