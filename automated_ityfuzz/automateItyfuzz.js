const fs = require("fs");
const util = require("util");
const exec = util.promisify(require("child_process").exec);

// Read the JSON file
const jsonString = fs.readFileSync("exact_block_exploits.json", "utf8");
const tasks = JSON.parse(jsonString);

// Function to execute ityfuzz command with a timeout
async function executeItyfuzzCommandWithTimeout(command, timeout) {
  return new Promise(async (resolve, reject) => {
    console.log(`Executing command: ${command}`);

    try {
      const {stdout, stderr} = await exec(command);

      setTimeout(() => {
        console.log("Command executed successfully:", stdout);
        resolve();
      }, timeout * 1000); // Convert seconds to milliseconds

      // Reject the promise if there's an error
      if (stderr) {
        console.error("Error executing command:", stderr);
        reject(stderr);
      }
    } catch (error) {
      console.error("Error executing command:", error.message);
      reject(error);
    }
  });
}

// Function to run tasks with a timeout
async function runTasksWithTimeout(timeout) {
  for (const task of tasks) {
    console.log(`Running task: ${task.name}`);

    try {
      await executeItyfuzzCommandWithTimeout(task.fuzzing_command, timeout);
    } catch (error) {
      // Handle errors, e.g., move to the next entry in the JSON array
      console.error("Error executing task:", error.message);
    }

    console.log("\n"); // Add a new line for better console output separation
  }
}

// Set the timeout (in seconds)
const timeout = 30;

// Run the tasks with a timeout
runTasksWithTimeout(timeout);
