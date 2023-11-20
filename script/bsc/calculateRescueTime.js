// otherFile.js
const {
  getFirstTransactionAfterCreation,
} = require("./getTransationsBlockWithAddress");

// Smart contract address to query
// MAD Incident
const contractAddress1 = "0x525c8e9c8240a55014BC55cbE8908EadADB02094";
const contractAddress = "0xD7ba198ce82f4c46AD8F6148CCFDB41866750231";
// Use the exported function
// can return them both here -> by adjust the index of smth +1 +2
// TODO: write the rescue time to the DB or a JSON
getFirstTransactionAfterCreation(contractAddress)
  .then((result) => {
    console.log("Created at Block # ");
    console.log(result.creationTransaction.blockNumber);
    console.log("First Transaction After Contract Creation:");
    console.log(result.firstTransactionAfterCreation.blockNumber);

    console.log("RESCUE TIME!: ");
    console.log(
      ((result.firstTransactionAfterCreation.blockNumber -
        result.creationTransaction.blockNumber) *
        3) /
        60 /
        60
    );
    console.log("Hours");
  })
  .catch((error) => {
    console.error(`Error: ${error.message}`);
  });
