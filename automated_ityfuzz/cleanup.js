const fs = require("fs");

// Function to delete the specified folder
function deleteFolder(folderPath) {
  try {
    fs.rmdirSync(folderPath, {recursive: true});
    console.log(`Deleted ${folderPath}`);
  } catch (error) {
    console.error(`Error deleting ${folderPath}:`, error.message);
  }
}

// Specify the folders to be deleted
const workDirPath = "./automated_ityfuzz/work_dir";
const resultTestPath = "./automated_ityfuzz/result_test";

// Delete the specified folders
deleteFolder(workDirPath);
deleteFolder(resultTestPath);
