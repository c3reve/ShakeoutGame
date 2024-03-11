const admin = require("firebase-admin/app");
admin.initializeApp();

const onScheduleNotification = require("./on_schedule_notification.js");
exports.onScheduleNotification = onScheduleNotification.onScheduleNotification;
const onScheduleDone = require("./on_schedule_done.js");
exports.onScheduleDone = onScheduleDone.onScheduleDone;
