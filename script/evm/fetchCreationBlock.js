const axios = require("axios");

async function getContractDeployBlock(contractAddress) {
  const apiKey = "FJMFRFSI3Z8WP9YVU6IBRVZ35IQKB5EPTH"; // Replace with your BSC Scan API key
  const apiUrl = `https://api.bscscan.com/api`;

  try {
    const response = await axios.get(apiUrl, {
      params: {
        module: "contract",
        action: "getsourcecode",
        address: contractAddress,
        apikey: apiKey,
      },
    });
    console.log(response.data);
    const contractData = response.data.result[0];

    if (contractData) {
      const blockNumber = contractData.blockNumber;
      console.log(
        `Contract at address ${contractAddress} was deployed in block ${blockNumber}`
      );
      return blockNumber;
    } else {
      console.log(`Contract not found at address ${contractAddress}`);
      return null;
    }
  } catch (error) {
    console.error("Error fetching contract deployment block:", error.message);
    return null;
  }
}

// Example usage
const contractAddress = "0x45aa258ad08eeeb841c1c02eca7658f9dd4779c0";
getContractDeployBlock(contractAddress);
