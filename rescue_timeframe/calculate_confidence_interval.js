// SCRIPT TO CALCULATE Confident interval for each attack vector
// Assuming the data is stored in a variable named 'rescueData'
const fs = require("fs");

function readJsonFromFile(filename) {
  try {
    const data = fs.readFileSync(filename, "utf8");
    return JSON.parse(data);
  } catch (error) {
    console.error("Error reading JSON file:", error.message);
    return null;
  }
}

// Assuming the JSON file is in the same directory as the script
const filename = __dirname + "/everyrescue.json";

const rescueData = readJsonFromFile(filename);

// Function to calculate the confidence interval
function calculateConfidenceInterval(data, confidenceLevel) {
  const n = data.length;
  const mean = data.reduce((sum, item) => sum + item.avg_rescue_time, 0) / n;

  // Calculate standard deviation
  const stdDev = Math.sqrt(
    data.reduce(
      (sum, item) => sum + Math.pow(item.avg_rescue_time - mean, 2),
      0
    ) /
      (n - 1)
  );

  // Calculate margin of error
  const zScore = getZScore(confidenceLevel);
  const marginOfError = zScore * (stdDev / Math.sqrt(n));

  // Calculate confidence interval
  const lowerBound = mean - marginOfError;
  const upperBound = mean + marginOfError;

  return {mean, stdDev, marginOfError, lowerBound, upperBound};
}

// Function to get Z-score based on confidence level
function getZScore(confidenceLevel) {
  // Z-scores for common confidence levels
  const zScores = {
    80: 1.282,
    85: 1.44,
    90: 1.645,
    95: 1.96,
    99: 2.576,
  };

  return zScores[confidenceLevel] || null;
}

// Calculate the 90% confidence interval
const confidenceInterval90 = calculateConfidenceInterval(rescueData, 90);

console.log("90% Confidence Interval:");
console.log("Mean:", confidenceInterval90.mean);
console.log("Standard Deviation:", confidenceInterval90.stdDev);
console.log("Margin of Error:", confidenceInterval90.marginOfError);
console.log("Lower Bound:", confidenceInterval90.lowerBound);
console.log("Upper Bound:", confidenceInterval90.upperBound);
