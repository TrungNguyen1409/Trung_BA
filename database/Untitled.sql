SELECT *
FROM Incident
WHERE incident_id IN (
    SELECT incident_id
    FROM IncidentCause
    WHERE cause_id IN (4, 5, 6)
);
