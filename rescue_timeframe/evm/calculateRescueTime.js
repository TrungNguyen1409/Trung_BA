const fs = require("fs");
const {
  getFirstTransactionAfterCreation,
} = require("./getTransationsBlockWithAddress");

const getAddressByChainType = require("./getAddressFromDB");

async function fetchTransactionsForAddresses() {
  try {
    // Get the array of addresses
    const addressArray = await getAddressByChainType("ETH");

    console.log(`Adversary Contracts with chain "ETH":`, addressArray);

    let rescueTimeArray = [];

    // Use a for loop to iterate through each address
    for (let i = 0; i < addressArray.length; i++) {
      try {
        // Call the function for each address
        const result = await getFirstTransactionAfterCreation(addressArray[i]);

        console.log(
          `Created at Block for ${addressArray[i]}: ${result.creationTransaction.blockNumber}`
        );
        console.log(
          `First Transaction After Contract Creation at Block: ${result.firstTransactionAfterCreation.blockNumber}`
        );

        console.log(
          `RESCUE TIME for ${addressArray[i]}: ${
            (result.firstTransactionAfterCreation.blockNumber -
              result.creationTransaction.blockNumber) *
            15
          } seconds`
        );

        // Push the rescue time to the array
        rescueTimeArray.push({
          address: addressArray[i],
          rescueTime:
            (result.firstTransactionAfterCreation.blockNumber -
              result.creationTransaction.blockNumber) *
            3,
        });
      } catch (error) {
        console.error(`Error for address ${addressArray[i]}: ${error.message}`);
        // Optionally, you can push a default or placeholder value if an error occurs
        // rescueTimeArray.push({ error: `Error for address ${addressArray[i]}: ${error.message}` });
      }
    }

    console.log(
      "total time: ",
      rescueTimeArray.reduce(
        (accumulator, entry) => accumulator + entry.rescueTime,
        0
      )
    );
    console.log(rescueTimeArray.length);

    // Write the rescueTimeArray to a JSON file
    const jsonContent = JSON.stringify(rescueTimeArray, null, 2);
    fs.writeFileSync("./rescueTimeArray.json", jsonContent);

    // Print the rescue time array
    console.log("Rescue Time Array:", rescueTimeArray);
    console.log("Rescue Time Array written to rescueTimeArray.json");
  } catch (error) {
    console.error("Error:", error);
  }
}

// Call the function
fetchTransactionsForAddresses();
