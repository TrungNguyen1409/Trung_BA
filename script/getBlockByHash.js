const axios = require("axios");

const transactionHash =
  "0xcda228e5ca5d98853c62b788833bc513474273a1eec8198de5e6e5048f30c1ca";
const apiUrl = `https://api.bscscan.com/api`;

axios
  .get(apiUrl, {
    params: {
      module: "proxy",
      action: "eth_getTransactionByHash",
      txhash: transactionHash,
      apikey: "FJMFRFSI3Z8WP9YVU6IBRVZ35IQKB5EPTH", // Replace with your BSCScan API key
    },
  })
  .then((response) => {
    const transaction = response.data.result;
    if (transaction) {
      console.log(`Block Number: ${parseInt(transaction.blockNumber, 16)}`);
    } else {
      console.log("Transaction not found");
    }
  })
  .catch((error) => {
    console.error("Error:", error.message);
  });
