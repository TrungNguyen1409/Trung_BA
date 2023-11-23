const fs = require("fs");
const util = require("util");
const exec = util.promisify(require("child_process").exec);
const fsExtra = require("fs-extra");

// Read the JSON file
const jsonString = fs.readFileSync("exact_block_exploits.json", "utf8");
const tasks = JSON.parse(jsonString);

const errorLogFile = "error_log.txt"; // Specify the correct file name

// Function to execute ityfuzz command with a timeout
async function executeItyfuzzCommandWithTimeout(
  command,
  timeout,
  executionName
) {
  const timeoutPromise = new Promise((_, reject) => {
    setTimeout(() => {
      reject(new Error(`Command execution for ${executionName} timed out`));
    }, timeout * 1000);
  });

  const executionPromise = new Promise(async (resolve, reject) => {
    console.log(`Executing command: ${command}`);

    try {
      const {stdout, stderr} = await exec(command);

      console.log("Command executed successfully. Output:");
      console.log(stdout);

      // Check if the "work_dir" folder exists before copying
      if (fs.existsSync("work_dir")) {
        // Copy the "work_dir" folder to a new folder named after the current execution
        const destinationFolder = `result_test/${executionName}`;
        fsExtra.copySync("work_dir", destinationFolder);
        console.log(`Copied "work_dir" to "${destinationFolder}"`);

        // Remove the "work_dir" folder
        fsExtra.removeSync("work_dir");
        console.log('Removed "work_dir"');
      } else {
        console.log('"work_dir" folder does not exist.');
      }

      resolve();
    } catch (error) {
      await fs.promises.writeFile(errorLogFile, error.message);

      if (fs.existsSync("work_dir")) {
        fsExtra.removeSync("work_dir");
        console.log('Removed "work_dir"');
      }
      console.error("Error executing command:", error.message);
      reject(error);
    }
  });

  return Promise.race([executionPromise, timeoutPromise]);
}

// Function to run tasks with a timeout
async function runTasksWithTimeout(timeout) {
  console.log(tasks);
  for (const task of tasks) {
    console.log(`Running task: ${task.name}`);

    try {
      await executeItyfuzzCommandWithTimeout(
        task.fuzzing_command,
        timeout,
        task.name
      );
    } catch (error) {
      // Handle errors, e.g., move to the next entry in the JSON array
      console.error("Error executing task:", error.message);
    }

    console.log("\n"); // Add a new line for better console output separation
  }
}

// Set the timeout (in seconds)
const timeout = 5;

// Run the tasks with a timeout
runTasksWithTimeout(timeout);
