// Pilot only: exercise an aged WIF token without changing the shared build action.
console.log(`WIF pilot build delay started at ${new Date().toISOString()}`);
setTimeout(() => {
  console.log(`WIF pilot build delay finished at ${new Date().toISOString()}`);
}, 11 * 60 * 1000);
