const fs = require("fs");
const path = require("path");

const directory = "."; // Specify the directory where you want to remove non-JSON files

fs.readdir(directory, (err, files) => {
  if (err) {
    console.error("Error reading directory:", err);
    return;
  }

  files.forEach((file) => {
    const filePath = path.join(directory, file);

    if (path.extname(file) !== ".json") {
      console.log("Removing non-JSON file:", filePath);
      // Uncomment the following line to actually remove the non-JSON file
      fs.unlinkSync(filePath);
    }
  });
});
