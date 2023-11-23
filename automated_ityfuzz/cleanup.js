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
const workDirPath = "./work_dir";
const resultTestPath = "./result_test";
const solutionPath = "./solutions";

// Delete the specified folders
deleteFolder(workDirPath);
deleteFolder(resultTestPath);
deleteFolder(solutionPath);
