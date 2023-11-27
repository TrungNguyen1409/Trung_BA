const fs = require("fs");
const path = require("path");

const directory = "."; // Specify the directory where JSON files are located

fs.readdir(directory, (err, files) => {
  if (err) {
    console.error("Error reading directory:", err);
    return;
  }

  files.forEach((file) => {
    const filePath = path.join(directory, file);

    // Check if the file has a .json extension
    if (path.extname(file) === ".json") {
      try {
        // Read the JSON file
        const jsonContent = JSON.parse(fs.readFileSync(filePath, "utf8"));

        // Stringify the JSON content with proper indentation (e.g., 2 spaces)
        const formattedJson = JSON.stringify(jsonContent, null, 2);

        // Write the formatted JSON back to the file
        fs.writeFileSync(filePath, formattedJson, "utf8");

        console.log("Formatted JSON file:", filePath);
      } catch (error) {
        console.error("Error formatting JSON file:", filePath, error);
      }
    }
  });
});
