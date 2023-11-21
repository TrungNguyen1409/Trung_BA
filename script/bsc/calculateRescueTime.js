// otherFile.js
const {
  getFirstTransactionAfterCreation,
} = require("./getTransationsBlockWithAddress");

const getAddressByChainType = require("./getAddressFromDB");

// Smart contract address to query
// MAD Incident
const addressArray = getAddressByChainType("BSC")
  .then((result) => {
    console.log(`Adversary Contracts with chain "bsc":`, result);
    return result;
  })
  .catch((error) => {
    console.error("Error:", error);
  });
const contractAddress1 = "0x525c8e9c8240a55014BC55cbE8908EadADB02094";
const contractAddress = "0xbf7fc9e12bcd08ec7ef48377f2d20939e3b4845d";
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

console.log(addressArray);
