const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code
const kSchedulerIntervalMinutes = 5;

exports.onScheduleDone = functions
  .region("asia-northeast1")
  .pubsub.schedule(`every ${kSchedulerIntervalMinutes} minutes synchronized`)
  .timeZone("Asia/Tokyo")
  .onRun(async (context) => {
    console.log("done");
  });
