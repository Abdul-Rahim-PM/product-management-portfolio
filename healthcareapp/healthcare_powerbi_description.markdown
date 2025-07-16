# Power BI Dashboards for Healthcare App

**Description**: Three dashboards visualizing no-show rates, appointment volumes, and patient engagement metrics.

- **No-Show Rate Dashboard**: Line chart showing daily no-show rates, calculated via DAX: `NoShowRate = DIVIDE(COUNT(appointments[no-show]), COUNT(appointments[id]), 0)`. Includes filters for hospital and date range.
- **Appointment Volume Dashboard**: Bar chart displaying bookings by hospital, with drill-down to weekly trends.
- **Engagement Metrics Dashboard**: Pie chart showing patient interaction rates (e.g., portal logins, reminder responses). Uses DAX: `EngagementRate = DIVIDE(SUM(appointments[booked]), COUNT(appointments[id]), 0)`. **Note**: Actual PBIX files are proprietary; this describes functionality for portfolio purposes.