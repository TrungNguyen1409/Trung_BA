SELECT
  strftime('%Y-%m', i.incident_date) AS month,
  COALESCE(AVG(a.rescue_time), 0) AS avg_rescue_time,
  COALESCE(MAX(a.rescue_time), 0) AS highest_rescue_time,
  COALESCE(MIN(a.rescue_time), 0) AS lowest_rescue_time
FROM
  Adversary a
RIGHT JOIN
  Incident i ON a.incident_id = i.incident_id
JOIN
  IncidentCause ic ON i.incident_id = ic.incident_id
JOIN
  Cause c ON ic.cause_id = c.cause_id
WHERE
  i.incident_date BETWEEN '2022-05-01' AND '2023-11-30'
  AND c.cause_id = 35 -- Replace your_cause_id with the specific cause_id you are interested in
GROUP BY
  month
ORDER BY
  month;
