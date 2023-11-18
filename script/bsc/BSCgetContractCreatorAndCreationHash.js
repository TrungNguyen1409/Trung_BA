const axios = require("axios");

// API endpoint URL
const apiUrl = "https://api.bscscan.com/api";

// API key (replace 'YourApiKeyToken' with your actual API key)
const apiKey = "FJMFRFSI3Z8WP9YVU6IBRVZ35IQKB5EPTH";

// Contract addresses to query
const contractAddresses = ["0x525c8e9c8240a55014BC55cbE8908EadADB02094"];

// Construct the API request URL
const requestUrl = `${apiUrl}?module=contract&action=getcontractcreation&contractaddresses=${contractAddresses.join(
  ","
)}&apikey=${apiKey}`;

// Make the API request
axios
  .get(requestUrl)
  .then((response) => {
    // Check if the request was successful
    if (response.data.status === "1") {
      // Output contract creation hashes
      const contractCreationHashes = response.data.result;
      console.log("Contract Creation Hashes:");
      console.log(contractCreationHashes);
    } else {
      console.error("Error:", response.data.message);
    }
  })
  .catch((error) => {
    console.error("Error:", error.message);
  });
