const fs = require("fs");
const sqlite3 = require("sqlite3").verbose();

const db = new sqlite3.Database("defi_sok_extended.db");
const query = "SELECT * FROM Incident";
db.all(query, [], (err, rows) => {
  if (err) {
    throw err;
  }
  const modifiedData = rows.map((row) => ({...row, adversarial_contract: ""}));
  const jsonData = JSON.stringify(modifiedData, null, 2);
  fs.writeFileSync("input.json", jsonData, "utf-8");
  console.log("Data saved to input.json");
  db.close();
});
