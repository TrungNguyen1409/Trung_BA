const fs = require("fs");
const util = require("util");
const exec = util.promisify(require("child_process").exec);
const fsExtra = require("fs-extra");

const jsonString = fs.readFileSync("exact_block_exploits.json", "utf8");
const tasks = JSON.parse(jsonString);

const errorLogFile = "error_log.txt";

async function executeItyfuzzCommandWithTimeout(
  command,
  timeout,
  executionName,
  id
) {
  const maxBuffer = 1024 * 1024 * 50;

  const timeoutPromise = new Promise((_, reject) => {
    setTimeout(() => {
      reject(new Error(`Command execution for ${executionName} timed out`));
      fs.promises.appendFile(
        errorLogFile,
        `${id} : ${executionName} : TIMEOUT\n`
      );
    }, timeout * 1000);
  });

  const executionPromise = new Promise(async (resolve, reject) => {
    console.log(`Executing command: ${command}`);

    try {
      const {stdout, stderr} = await exec(command, {maxBuffer});

      console.log("Command executed successfully. Output:");
      console.log(stdout);

      if (fs.existsSync("work_dir")) {
        const destinationFolder = `result_test/${executionName}`;

        fsExtra.copySync("work_dir", destinationFolder);
        console.log(`Copied "work_dir" to "${destinationFolder}"`);

        fsExtra.removeSync("work_dir");
        console.log('Removed "work_dir"');
      } else {
        console.log('"work_dir" folder does not exist.');
      }

      resolve();
    } catch (error) {
      await fs.promises.appendFile(
        errorLogFile,
        `${executionName} : ${error.message}\n`
      );
      if (fs.existsSync("work_dir")) {
        fsExtra.removeSync("work_dir");
        console.log('Removed "work_dir"');
      } else {
        console.log('"work_dir" folder does not exist.');
      }
    }
  });

  return Promise.race([executionPromise, timeoutPromise]);
}

async function runTasksWithTimeout(timeout) {
  console.log(tasks);

  for (const task of tasks) {
    console.log(`Running task: ${task.name}`);

    try {
      await executeItyfuzzCommandWithTimeout(
        task.fuzzing_command,
        timeout,
        task.name,
        task.id
      );
    } catch (error) {
      console.error("Error executing task:", error.message);
    }

    console.log("\n");
  }
}

const timeout = 2700;
runTasksWithTimeout(timeout);
