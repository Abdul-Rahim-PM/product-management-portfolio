-- SQL Queries for Internal Process Automation Tool
-- 1. Analyze allocation time by project
SELECT project_id, AVG(time_to_assign) AS avg_allocation_time
FROM allocations
GROUP BY project_id
ORDER BY avg_allocation_time DESC;

-- 2. Count assignments by resource
SELECT resource_id, COUNT(*) AS assignments
FROM allocations
GROUP BY resource_id
ORDER BY assignments DESC;

-- 3. Resource utilization rate
SELECT resource_id, 
       ROUND(SUM(hours) / SUM(available_hours) * 100, 2) AS utilization_rate
FROM allocations
GROUP BY resource_id;

-- 4. Identify unassigned resources
SELECT r.resource_id, r.name
FROM resources r
LEFT JOIN allocations a ON r.resource_id = a.resource_id
WHERE a.resource_id IS NULL;

-- 5. Allocation by skill
SELECT s.skill_name, COUNT(*) AS assignments
FROM allocations a
JOIN resources_skills rs ON a.resource_id = rs.resource_id
JOIN skills s ON rs.skill_id = s.skill_id
GROUP BY s.skill_name
ORDER BY assignments DESC;

-- 6. Project staffing gaps
SELECT p.project_id, p.project_name, 
       p.required_resources - COUNT(a.resource_id) AS staffing_gap
FROM projects p
LEFT JOIN allocations a ON p.project_id = a.project_id
GROUP BY p.project_id, p.project_name
HAVING staffing_gap > 0;

-- 7. Allocation efficiency by team
SELECT t.team_id, t.team_name, 
       AVG(a.time_to_assign) AS avg_allocation_time
FROM allocations a
JOIN teams t ON a.team_id = t.team_id
GROUP BY t.team_id, t.team_name;

-- 8. Overallocated resources
SELECT resource_id, SUM(hours) AS total_hours
FROM allocations
GROUP BY resource_id
HAVING SUM(hours) > 40;