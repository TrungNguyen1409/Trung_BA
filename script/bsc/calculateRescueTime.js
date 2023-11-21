// otherFile.js
const {
  getFirstTransactionAfterCreation,
} = require("./getTransationsBlockWithAddress");

// Smart contract address to query
// MAD Incident
const contractAddress1 = "0x525c8e9c8240a55014BC55cbE8908EadADB02094";
const contractAddress = "0x3463a663de4ccc59c8b21190f81027096f18cf2a";
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
      (result.firstTransactionAfterCreation.blockNumber -
        result.creationTransaction.blockNumber) *
        3
    );
    console.log("seconds");
  })
  .catch((error) => {
    console.error(`Error: ${error.message}`);
  });
