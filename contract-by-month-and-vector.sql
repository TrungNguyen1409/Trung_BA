SELECT
  DISTINCT a.adversary_contract,
  strftime('%Y-%m', i.incident_date) AS month
FROM
  Adversary a
JOIN
  Incident i ON a.incident_id = i.incident_id
JOIN
  IncidentCause ic ON i.incident_id = ic.incident_id
JOIN
  Cause c ON ic.cause_id = c.cause_id
WHERE
  a.chain = 'BSC'
  AND c.cause_id = 26
  AND i.incident_date BETWEEN '2020-05-01' AND '2023-11-30'
ORDER BY
  month, a.adversary_contract;
