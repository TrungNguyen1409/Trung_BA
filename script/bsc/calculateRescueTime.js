// otherFile.js
const {
  getFirstTransactionAfterCreation,
} = require("./getTransationsBlockWithAddress");

// Smart contract address to query
// MAD Incident
const contractAddress1 = "0x525c8e9c8240a55014BC55cbE8908EadADB02094";
const contractAddress = "0x71Ac864f9388eBD8e55a3cdBC501D79C3810467C";
// Use the exported function
// can return them both here -> by adjust the index of smth +1 +2
// TODO: write the rescue time to the DB or a JSON
getFirstTransactionAfterCreation(contractAddress)
  .then((result) => {
    console.log(`Created at Block: ${result.creationTransaction.blockNumber}`);
    console.log(
      `First Transaction After Contract Creation at Block: ${result.firstTransactionAfterCreation.blockNumber}`
    );

    console.log(
      `RESCUE TIME!: ${
        (result.firstTransactionAfterCreation.blockNumber -
          result.creationTransaction.blockNumber) *
        3
      } seconds`
    );
  })
  .catch((error) => {
    console.error(`Error: ${error.message}`);
  });
