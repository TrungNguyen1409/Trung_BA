SELECT
  strftime('%Y-%m', i.incident_date) AS month,
  AVG(a.rescue_time) AS avg_rescue_time
FROM
  Adversary a
JOIN
  Incident i ON a.incident_id = i.incident_id
WHERE
  i.incident_date BETWEEN '2022-05-01' AND '2023-11-30'
GROUP BY
  month
ORDER BY
  month;
