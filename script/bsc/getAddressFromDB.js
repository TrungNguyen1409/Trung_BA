const sqlite3 = require("sqlite3").verbose();

const db = new sqlite3.Database("../../database/defi_sok_extended.db"); // Replace with your actual database name

const getAddressByChainType = (chainType) => {
  return new Promise((resolve, reject) => {
    const query = `
      SELECT adversary_contract
      FROM Adversary
      WHERE chain = ?;
    `;

    let addressArray = [];

    db.all(query, [chainType], (err, rows) => {
      if (err) {
        throw err;
      }

      console.log(`Adversary Contracts with chain "${chainType}":`);
      rows.forEach((row) => {
        addressArray.push(row.adversary_contract);
      });

      // Close the database connection
      db.close();
      resolve(addressArray);
    });
  });
};

module.exports = getAddressByChainType;
