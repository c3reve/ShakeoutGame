const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code

exports.onScheduleNotification = functions
  .region("asia-northeast1")
  .pubsub.schedule("0 0 * * *")
  .timeZone("Asia/Tokyo")
  .onRun(async (context) => {
    // 午前と午後に１回送信
    await addSchedule(randomDate(0 * 60, 12 * 60));
    await addSchedule(randomDate(12 * 60, 24 * 60));
  });

/**
 * スケジュール追加
 */
async function addSchedule(date) {
  const db = admin.firestore();
  const timestamp = admin.firestore.FieldValue.serverTimestamp();

  // スライダーの値
  const sliderValue = randomNumber(5, 95);
  // クイズ
  const quizCount = await db.collection("quizzes").count().get();
  const quizNo = randomNumber(1, quizCount.data().count);
  const quizSnapshot = await db
    .collection("quizzes")
    .where("no", "==", quizNo)
    .get();
  const quiz = quizSnapshot.docs[0];

  // スケジュール
  const expired = new Date(date);
  // 期限を360分に設定
  expired.setMinutes(expired.getMinutes() + 360);
  const scheduleRef = await db.collection("schedules").add({
    start_time: date,
    end_time: expired,
    done_date: null,
    sliderValue,
    quizRef: quiz.ref,
    created_time: timestamp,
  });

  await db.collection("ff_push_notifications").add({
    scheduled_time: date,
    scheduleRef,
    status: "started",
    target_audience: "All",
    notification_title: "Earthquake drill occurred!",
    notification_text: `Let's do an evacuation drill now!`,
    notification_sound: "default",
    initial_page_name: "Play",
    parameter_data: `{"scheduleRef":"/schedules/${scheduleRef.id}","mode":"Real"}`,
    timestamp,
  });
}

function randomNumber(min, max) {
  // Math.random() * (最大値 - 最小値 + 1) + 最小値
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

function randomDate(minTime, maxTime) {
  // ランダムな時間生成
  const randomTime =
    Math.floor(Math.random() * (maxTime - minTime + 1)) + minTime;

  // Date型に変換
  const date = new Date();
  date.setHours(Math.floor(randomTime / 60));
  date.setMinutes(randomTime % 60);

  return date;
}
