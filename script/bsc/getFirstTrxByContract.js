// getFirstTransaction.js
const axios = require("axios");

// API endpoint URL
const apiUrl = "https://api.bscscan.com/api";

// API key (replace 'YourApiKeyToken' with your actual API key)
const apiKey = "FJMFRFSI3Z8WP9YVU6IBRVZ35IQKB5EPTH";

// Smart contract address to query
const contractAddress = "0x525c8e9c8240a55014BC55cbE8908EadADB02094";

// Function to get contract creation hashes
async function getContractCreationHashes(contractAddresses) {
  const requestUrl = `${apiUrl}?module=contract&action=getcontractcreation&contractaddresses=${contractAddresses.join(
    ","
  )}&apikey=${apiKey}`;

  try {
    const response = await axios.get(requestUrl);

    if (response.data.status === "1") {
      return response.data.result;
    } else {
      throw new Error(
        `Error fetching contract creation hashes: ${response.data.message}`
      );
    }
  } catch (error) {
    throw new Error(
      `Error fetching contract creation hashes: ${error.message}`
    );
  }
}

// Function to get all transactions for a contract address
async function getContractTransactions(contractAddress) {
  const transactionUrl = `${apiUrl}?module=account&action=txlist&address=${contractAddress}&apikey=${apiKey}`;

  try {
    const response = await axios.get(transactionUrl);

    if (response.data.status === "1") {
      return response.data.result;
    } else {
      throw new Error(
        `Error fetching contract transactions: ${response.data.message}`
      );
    }
  } catch (error) {
    throw new Error(`Error fetching contract transactions: ${error.message}`);
  }
}

// Function to get the first transaction after contract creation
async function getFirstTransactionAfterCreation(contractAddress) {
  try {
    // Get contract creation transaction hash
    const contractCreationHashes = await getContractCreationHashes([
      contractAddress,
    ]);
    const creationTxHash = contractCreationHashes[0];

    // Get all transactions for the contract address
    const transactions = await getContractTransactions(contractAddress);

    // Find the index of the contract creation transaction
    const creationTxIndex = transactions.findIndex(
      (tx) => tx.hash === creationTxHash
    );

    // Get the first transaction after the contract creation
    const firstTransactionAfterCreation = transactions[creationTxIndex + 2];

    return firstTransactionAfterCreation;
  } catch (error) {
    throw new Error(`Error: ${error.message}`);
  }
}

// Get the first transaction after contract creation
getFirstTransactionAfterCreation(contractAddress)
  .then((result) => {
    console.log("First Transaction After Contract Creation:");
    console.log(result);
  })
  .catch((error) => {
    console.error(`Error: ${error.message}`);
  });
