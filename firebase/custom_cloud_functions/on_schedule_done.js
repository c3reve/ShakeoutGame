const functions = require("firebase-functions");
const admin = require("firebase-admin");
// To avoid deployment errors, do not call admin.initializeApp() in your code
const { GoogleAuth } = require("google-auth-library");
const jwt = require("jsonwebtoken");

const kSchedulerIntervalMinutes = 15;
const issuerId = "3388000000022314504";
const classId = "shakeout-game";

const createItemObject = (issuerId, classSuffix, objectSuffix, item) => {
  return {
    id: `${issuerId}.${objectSuffix}`,
    classId: `${issuerId}.${classSuffix}`,
    logo: {
      sourceUri: {
        uri: "https://firebasestorage.googleapis.com/v0/b/shakeout-game-r5t581.appspot.com/o/assets%2Fimages%2Flogo.png?alt=media&token=d19e1bab-3757-4d8d-bf10-526d008a3008",
      },
      contentDescription: {
        defaultValue: {
          language: "en-US",
          value: "LOGO_IMAGE_DESCRIPTION",
        },
      },
    },
    cardTitle: {
      defaultValue: {
        language: "en-US",
        value: "ShakeOut Game",
      },
    },
    subheader: {
      defaultValue: {
        language: "en-US",
        value: "ShakeOut",
      },
    },
    header: {
      defaultValue: {
        language: "ja-JP",
        // "language": "en-US",
        value: item.input_name,
      },
    },
    textModulesData: [
      {
        id: "score",
        header: "Score",
        body: "Time",
      },
      {
        id: "11.234",
        header: "",
        body: "11.234",
      },
    ],
    barcode: {
      type: "TEXT_ONLY",
      value: item.input_name,
      alternateText: "",
    },
    hexBackgroundColor: "#0F3143",
    heroImage: {
      sourceUri: {
        uri: item.imagePath,
      },
      contentDescription: {
        defaultValue: {
          language: "en-US",
          value: "HERO_IMAGE_DESCRIPTION",
        },
      },
    },
  };
};

exports.onScheduleDone = functions
  .region("asia-northeast1")
  .pubsub.schedule(`every ${kSchedulerIntervalMinutes} minutes synchronized`)
  .timeZone("Asia/Tokyo")
  .onRun(async (context) => {
    const now = new Date();
    const db = admin.firestore();
    const batch = db.batch();
    const timestamp = admin.firestore.FieldValue.serverTimestamp();
    // 未完了のスケジュールを取得
    const schedulesSnapshot = await db
      .collection("schedules")
      .where("done_time", "==", null)
      .get();
    const targetSchedules = schedulesSnapshot.docs.filter(
      (doc) => doc.data().end_time.toDate().getTime() < now.getTime(),
    );

    // 未完了のスケジュールあり
    if (targetSchedules.length) {
      // アイテム取得
      const { docs: items } = await db.collection("items").get();
      const randomItem = () => {
        const random = Math.floor(Math.random() * items.length);
        return items[random];
      };
      const pass = new GenericPass();

      console.log("1");

      for (const schedule of targetSchedules) {
        // 上位者を取得
        const scores = await db
          .collection("scores")
          .where("scheduleRef", "==", schedule.ref)
          .orderBy("time", "desc")
          .limit(3)
          .get();
        // console.log(scores.docs.map((user) => `${user.id}: ${user.data().time}`));

        for (const score of scores.docs) {
          console.log(`user: ${score.id}`);
          const userItems = db.collection("user_items");
          const userItemId = userItems.doc().id;
          const userItemRef = userItems.doc(userItemId);
          const item = randomItem();
          const objectId = await pass.createObject(
            issuerId,
            classId,
            userItemId,
            item.data(),
          );
          const passUrl = pass.createJwtNewObjects(
            issuerId,
            classId,
            userItemId,
            item.data(),
          );
          batch.set(userItemRef, {
            userRef: score.data().userRef,
            itemRef: item.ref,
            scheduleRef: schedule.ref,
            passUrl,
            objectId,
            created_time: timestamp,
          });
        }
        // 完了日を設定
        batch.update(schedule.ref, { done_time: timestamp });
      }
    }

    await batch.commit();
  });

class GenericPass {
  constructor() {
    this.baseUrl = "https://walletobjects.googleapis.com/walletobjects/v1";
    this.batchUrl = "https://walletobjects.googleapis.com/batch";
    this.classUrl = `${this.baseUrl}/genericClass`;
    this.objectUrl = `${this.baseUrl}/genericObject`;

    this.auth();
  }

  /**
   * Create authenticated HTTP client using a service account file.
   */
  auth() {
    this.credentials = {
      type: "service_account",
      project_id: "shakeout-game-r5t581",
      private_key_id: "d8c877a891d8610388b93e707929ff6a04c7a5b1",
      private_key:
        "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC3+8HwCNkAUyGX\nQiYS13QxlbHdHnxyFU0DNk5TxEdjxylar67BT0+2iIrFeINORyPRiR6wZz1L1m7/\nT8CLibKLeHFRq+ErgmvF84/fYT0b2Qed38+Z00XUT4MSDuP4/DvXGBIsMswEzoWr\nVxqKxFthW/sGVGHTw6L7oTjzsoohgjeArlgy1HKeu17VHPlDMFxNUzvptE1wFnAS\n/eODhw4YTcWTrA8/P6Btc8bRFR6s9QP1Hqzng5aWez0lXhvts/cZOs8TCzhgY+XO\nWetsI10NkNzPMnj6yB0+45I4OZ6oANq+8bNG1Da9R9nBnOT1qqFRHxS9JUDE7ja4\nlVJrQAKZAgMBAAECggEAAZRBGWDSD/0mrCgusHm17xkEUkwJMGd7ZjwolvJ31GTo\nt3ULkHAwVHY+jqxWoCzfI1TEdSolrgl0oW9bTTdM14KcomFRyPBRIX1SLk4k2qDV\nvmal3wGft09JZjXHgiMUFmgH++YhtybYodxZB3jg+ehysp61yj4DH5rGJN1S7y+t\nrwvd0Bd8hDbisOAOECwaw9GX/4S1O/J7j1TBzoFtIhLVpTcLrV7NuAshJJL/kioA\nn2cEx7Ds3JZ5nRNrTmYwzMibzI2N1ngZq/dMy9iOJ0tOGfWUC0gePUB33JllEBdJ\nMojrOvJsMuyBbzGzytPNchzVrbuTv8aIix4V8UAduwKBgQDz5n8J7VPjzDZ/OIz2\nCteNdLspfzq3+f/4477Q3LREtsWiyoaFPDI/YULgeQZD+m3Vs6Q2EYyo/9bg0WQi\nUX02yv5TRbk+A221NtPAmnd2Vc+nBMSGfoAKKrTVlgJ4NUCPqGbytsks0HK/PLod\nO6i3eCmROAKJcQ3Bb/IGlKFZswKBgQDBHFLeVUt8+0vM1VbslrTE3ljlFNH87a7s\nsCBKSIJle/Fk+1l4h0VRMDa7PketVwRu7MNtLthpX2ubkLgJnyxrqqpa9eRYj4HY\nRSluyq9QmYI5ifMQ0Gc9dp6ke2oMg254OcKcNv/SeK+fF9MVw7/MTcuCzoUHREZC\nA9t5ps50gwKBgAI+fa6+s0XmTB4RjCJ7aQ5RI6O3Gvg0YamNluTfEv2K3PipemFh\nc2jn4TCljGw1sqsDsyAYOz4W1IhPBOfX7hoB9iMYAiNS7sB7F6mvAihhk76KqbA/\nG7h8Ohu4/J7UhpqLxx62ldVGubeOvHumX+AISAGhDUzscF72Q7jRx0ZHAoGBAK5f\njwyoZHPEztt1QPp901l5lTe2Jy+GyE99corhEq3kz0LqHA5Tx2naaXGGeV6ylpQ7\nQvRSOqRbv2VHtocprgjCoPVl1/2ICC1rtlAOwWO8WfTu9gcWyEKd2/6WWlpWS+hP\n78TzfOlmhN7ZuoeKrKQlE0FYjpLTOcXeic49q2tVAoGAJkaZcAZyvaK2ZYO4LT5H\nYRMQ6Fh67E7K6lB3iTWKj5xHGfW7r9EP5yBIu/eiHdDy6Z5e6RC0XKVUn3FQlLBV\nIh5mAqLMpUGENcIvXmrk4BJtp07MRCIME/XDzw+GFJxOAiIW9QwPlAlnPbdz8Lbk\np2o2mavyZDabGuA4rNQdPvs=\n-----END PRIVATE KEY-----\n",
      client_email:
        "wallet-web-client@shakeout-game-r5t581.iam.gserviceaccount.com",
      client_id: "116972987469169446157",
      auth_uri: "https://accounts.google.com/o/oauth2/auth",
      token_uri: "https://oauth2.googleapis.com/token",
      auth_provider_x509_cert_url: "https://www.googleapis.com/oauth2/v1/certs",
      client_x509_cert_url:
        "https://www.googleapis.com/robot/v1/metadata/x509/wallet-web-client%40shakeout-game-r5t581.iam.gserviceaccount.com",
      universe_domain: "googleapis.com",
    };

    this.httpClient = new GoogleAuth({
      credentials: this.credentials,
      scopes: "https://www.googleapis.com/auth/wallet_object.issuer",
    });
  }

  async createObject(issuerId, classSuffix, objectSuffix, item) {
    let response;

    try {
      response = await this.httpClient.request({
        url: `${this.objectUrl}/${issuerId}.${objectSuffix}`,
        method: "GET",
      });

      console.log(`Object ${issuerId}.${objectSuffix} already exists!`);

      return `${issuerId}.${objectSuffix}`;
    } catch (err) {
      if (err.response && err.response.status !== 404) {
        console.log(err);
        return `${issuerId}.${objectSuffix}`;
      }
    }

    response = await this.httpClient.request({
      url: this.objectUrl,
      method: "POST",
      data: createItemObject(issuerId, classSuffix, objectSuffix, item),
    });

    return `${issuerId}.${objectSuffix}`;
  }

  createJwtNewObjects(issuerId, classSuffix, objectSuffix, item) {
    let newClass = {
      id: `${issuerId}.${classSuffix}`,
    };

    let claims = {
      iss: this.credentials.client_email,
      aud: "google",
      origins: ["shakeout.flutterflow.app"],
      typ: "savetowallet",
      payload: {
        genericClasses: [newClass],
        genericObjects: [
          createItemObject(issuerId, classSuffix, objectSuffix, item),
        ],
      },
    };

    let token = jwt.sign(claims, this.credentials.private_key, {
      algorithm: "RS256",
    });

    return `https://pay.google.com/gp/v/save/${token}`;
  }
}
