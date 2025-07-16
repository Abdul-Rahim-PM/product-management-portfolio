# Power BI Dashboards for Fintech Dashboard

**Description**: Three dashboards visualizing fraud detection rates, transaction volumes, and alert trends.
- **Fraud Detection Dashboard**: Line chart showing fraud alert accuracy, calculated via DAX: `FraudAccuracy = DIVIDE(COUNT(transactions[true_positives]), COUNT(transactions[flagged]), 0)`. Includes date filters.
- **Transaction Volume Dashboard**: Bar chart displaying daily transaction amounts, with drill-down to hourly trends.
- **Alert Trends Dashboard**: Area chart showing alert frequency by type (e.g., fraud, high-value). Uses DAX: `TransactionSpeed = AVERAGE(transactions[processing_time])`.
**Note**: Actual PBIX files are proprietary; this describes functionality for portfolio purposes.