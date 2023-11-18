const axios = require("axios");

// API endpoint URL
const apiUrl = "https://api.bscscan.com/api";

// API key (replace 'YourApiKeyToken' with your actual API key)
const apiKey = "FJMFRFSI3Z8WP9YVU6IBRVZ35IQKB5EPTH";

// Contract addresses to query
const contractAddresses = ["0x525c8e9c8240a55014BC55cbE8908EadADB02094"];

// Function to get contract creation hashes
function getContractCreationHashes(contractAddresses) {
  const requestUrl = `${apiUrl}?module=contract&action=getcontractcreation&contractaddresses=${contractAddresses.join(
    ","
  )}&apikey=${apiKey}`;

  return axios
    .get(requestUrl)
    .then((response) => {
      if (response.data.status === "1") {
        return response.data.result;
      } else {
        throw new Error(
          `Error fetching contract creation hashes: ${response.data.message}`
        );
      }
    })
    .catch((error) => {
      throw new Error(
        `Error fetching contract creation hashes: ${error.message}`
      );
    });
}

// Function to get internal transactions by transaction hash
function getInternalTransactions(txHash) {
  const internalTxUrl = `${apiUrl}?module=account&action=txlistinternal&txhash=${txHash}&apikey=${apiKey}`;

  return axios
    .get(internalTxUrl)
    .then((response) => {
      return response.data;
    })
    .catch((error) => {
      throw new Error(`Error fetching internal transactions: ${error.message}`);
    });
}

// Main function
async function main() {
  try {
    // Get contract creation hashes
    const contractCreationHashes = await getContractCreationHashes(
      contractAddresses
    );

    // Use the first contract creation hash as an example
    const firstTxHash = contractCreationHashes[0].txHash;

    // Get internal transactions using the transaction hash
    const internalTransactions = await getInternalTransactions(firstTxHash);

    // Print out the response
    console.log("Internal Transactions:");
    console.log(internalTransactions.result[0].blockNumber);
  } catch (error) {
    console.error(`Error: ${error.message}`);
  }
}

// Call the main function
main();
