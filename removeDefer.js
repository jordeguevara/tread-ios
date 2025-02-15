const fs = require("fs");
const path = "./Tread/schema.graphqls"; // Adjust if your schema path differs

// Load the schema SDL
let schema = fs.readFileSync(path, "utf8");

// A regex that matches each occurrence of a `@defer` directive block.
// This is a rough pattern; you might need to tweak depending on how it's formatted.
const directiveRegex = /directive\s+@defer\s*\([^)]*\)\s*on\s+[A-Z_\s\|]+/g;

let matchCount = 0;
schema = schema.replace(directiveRegex, (match) => {
  matchCount++;
  // Keep the *first* occurrence, remove subsequent ones
  return matchCount === 1 ? match : "";
});

// Write the patched schema back
fs.writeFileSync(path, schema, "utf8");
console.log(`Patched ${path}: removed ${matchCount - 1} extra @defer definition(s).`);
//TODO Figure out why we even need this script (its cause fetching schema grabs two defers )