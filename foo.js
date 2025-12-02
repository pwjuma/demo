// This script defines a simple foo function that depends on a lucky function.

// Placeholder for the lucky function. Replace or implement it as needed.
function lucky() {
  // Example implementation: returns true 50% of the time
  return Math.random() > 0.5;
}

// foo function definition
function foo() {
  if (lucky()) {
    return true;
  }
  
  return false;
}

// Example usage
console.log(foo());
