SELECT
  SUM(i.avg_reported_damage_in_usd) AS total_damage
FROM
  Incident i
JOIN
  IncidentCause ic ON i.incident_id = ic.incident_id
JOIN
  Cause c ON ic.cause_id = c.cause_id
WHERE
  c.cause_id = 24
  AND i.incident_date BETWEEN '2022-05-01' AND '2023-10-30';
