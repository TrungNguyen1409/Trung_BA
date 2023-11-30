SELECT
  strftime('%Y-%m', incident_date) AS month,
  SUM(avg_reported_damage_in_usd) AS total_loss
FROM
  Incident
WHERE
  incident_date BETWEEN '2022-05-01' AND '2023-10-31'
GROUP BY
  month
ORDER BY
  month;
