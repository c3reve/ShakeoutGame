const admin = require("firebase-admin/app");
admin.initializeApp();

const onScheduleNotification = require("./on_schedule_notification.js");
exports.onScheduleNotification = onScheduleNotification.onScheduleNotification;
