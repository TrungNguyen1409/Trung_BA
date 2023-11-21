// otherFile.js
const {
  getFirstTransactionAfterCreation,
} = require("./getTransationsBlockWithAddress");

const getAddressByChainType = require("./getAddressFromDB");

// Smart contract address to query
const contractAddress = "0xbf7fc9e12bcd08ec7ef48377f2d20939e3b4845d";

let rescueTimeArray = [];

// Use Promise chaining to ensure getAddressByChainType is completed before using its result
getAddressByChainType("BSC")
  .then((addressArray) => {
    console.log(`Adversary Contracts with chain "BSC":`, addressArray);

    // Use the exported function
    // can return them both here -> by adjusting the index of something +1 +2
    // TODO: write the rescue time to the DB or a JSON

    getFirstTransactionAfterCreation(contractAddress)
      .then((result) => {
        console.log(
          `Created at Block: ${result.creationTransaction.blockNumber}`
        );
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
        rescueTimeArray.push(
          (result.firstTransactionAfterCreation.blockNumber -
            result.creationTransaction.blockNumber) *
            3
        );
        console.log(rescueTimeArray);
      })
      .catch((error) => {
        console.error(`Error: ${error.message}`);
      });
  })
  .catch((error) => {
    console.error("Error:", error);
  });
