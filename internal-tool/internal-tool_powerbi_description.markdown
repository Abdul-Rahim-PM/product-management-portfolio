# Power BI Dashboards for Internal Tool

**Description**: Two dashboards visualizing allocation time and team utilization.
- **Allocation Time Dashboard**: Line chart showing average allocation time by project, calculated via DAX: `AllocationTime = AVERAGE(allocations[time_to_assign])`. Includes filters for team and date.
- **Utilization Dashboard**: Bar chart displaying resource utilization rates, calculated via DAX: `UtilizationRate = DIVIDE(SUM(allocations[hours]), SUM(resources[available_hours]), 0)`.
**Note**: Actual PBIX files are proprietary; this describes functionality for portfolio purposes.