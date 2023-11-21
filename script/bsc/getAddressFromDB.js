const sqlite3 = require("sqlite3").verbose();

// Connect to the SQLite database
const db = new sqlite3.Database("../../database/defi_sok_extended.db"); // Replace with your actual database name

// SQL query to select adversary_contract values where chain is "bsc"
const query = `
    SELECT adversary_contract
    FROM Adversary
    WHERE chain = 'BSC';
`;

const getAddressByChainType = (chainType) => {
  return new Promise((resolve, reject) => {
    const query = `
      SELECT adversary_contract
      FROM Adversary
      WHERE chain = ?;
    `;

    let addressArray = [];

    // Execute the query
    db.all(query, [chainType], (err, rows) => {
      if (err) {
        throw err;
      }

      // Process the results
      console.log(`Adversary Contracts with chain "${chainType}":`);
      rows.forEach((row) => {
        addressArray.push(row.adversary_contract);
      });

      // Close the database connection
      db.close();

      //console.log(addressArray);
      resolve(addressArray);
    });
  });
};

module.exports = getAddressByChainType;
