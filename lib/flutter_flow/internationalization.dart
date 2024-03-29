import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['ja', 'en'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? jaText = '',
    String? enText = '',
  }) =>
      [jaText, enText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // MainMenu
  {
    '90lh48ob': {
      'ja': 'シェイクアウト\nゲーム',
      'en': 'shake out\ngame',
    },
    '45xdkaj0': {
      'ja': 'はじめる',
      'en': 'Start',
    },
    'naw8gn6b': {
      'ja': 'ランキング',
      'en': 'Ranking',
    },
    'hf1hdpl1': {
      'ja': 'マイアイテム',
      'en': 'Setting',
    },
    'q2429vqk': {
      'ja': 'ランキング',
      'en': 'Ranking',
    },
    'vr9bvcxt': {
      'ja': '設定',
      'en': 'Setting',
    },
    '7whih7pd': {
      'ja': '開発用',
      'en': 'For development',
    },
    'xeijx7fg': {
      'ja': 'Home',
      'en': 'Home',
    },
  },
  // Settings
  {
    's0nsto89': {
      'ja': '画像を変更',
      'en': 'change image',
    },
    'i8d4xdx1': {
      'ja': 'ニックネーム',
      'en': 'nickname',
    },
    '2r9iqu4e': {
      'ja': '効果音',
      'en': 'Sound effect',
    },
    'dvjbrxng': {
      'ja': 'BGM',
      'en': 'BGM',
    },
    'y19j4wyr': {
      'ja': 'BGMの音量',
      'en': 'BGM volume',
    },
    '9pd1oliu': {
      'ja': '振動',
      'en': 'vibration',
    },
    'xhaw44e7': {
      'ja': 'チュートリアル',
      'en': 'tutorial',
    },
    'xr2qhw6n': {
      'ja': 'Logout',
      'en': 'Logout',
    },
    'fth0uaoi': {
      'ja': '設定',
      'en': 'setting',
    },
    'fknrq7qx': {
      'ja': 'Home',
      'en': 'Home',
    },
  },
  // LeaderBoard
  {
    'mitx0bah': {
      'ja': 'Leaderboard',
      'en': 'Leaderboard',
    },
    '2wtmfw1d': {
      'ja': 'Home',
      'en': 'Home',
    },
  },
  // Play
  {
    '245emor1': {
      'ja': '中止',
      'en': 'cancel',
    },
    'r8exkvdf': {
      'ja': '残り時間',
      'en': 'Remaining time',
    },
    'eegru5tv': {
      'ja': '地震が発生したら体勢を低くして地面に近づきましょう。',
      'en': 'If an earthquake occurs, stay low and get close to the ground.',
    },
    '5r7gmes2': {
      'ja': '残り時間１分以内にゲームをクリアしてください！\nボールが円の中で止め、下のボタンを下にスワイプすると次に進みます。',
      'en':
          'Clear the game within 1 minute remaining!\nWhen the ball stops in the circle, swipe down on the bottom button to move on.',
    },
    'kpohh8hb': {
      'ja': '固定されたデスクやテーブルの下に入り、頭を守りましょう。\n頭を守るものがない場合は、腕や荷物を使って、頭を守りましょう。',
      'en':
          'Protect your head by getting under a fixed desk or table.\nIf you don\'t have something to protect your head, use your arms or luggage to protect your head.',
    },
    'gzbu9h8b': {
      'ja': 'スライドの数値を合わせ、下のボタンを横にスワイプしましょう。',
      'en':
          'Match the numbers on the slides and swipe the button below horizontally.',
    },
    'fnmlbbtm': {
      'ja': '揺れが止まるまで動かずじっとしていましょう。',
      'en': 'Stay still and do not move until the shaking stops.',
    },
    '5ozpsbq3': {
      'ja': 'クイズの正解を選択し、下のボタンを長押ししましょう。',
      'en':
          'Select the correct answer to the quiz and press and hold the button below.',
    },
    '2z6gscgr': {
      'ja': 'DROPを下にスワイプ！',
      'en': 'Swipe down on DROP!',
    },
    'rtq7r6xo': {
      'ja': 'COVERを右にスワイプ！',
      'en': 'Swipe right on COVER!',
    },
    '6eq3vrfr': {
      'ja': 'HOLD ONを長押し！',
      'en': 'Long press HOLD ON!',
    },
    '4hl9up9h': {
      'ja': '期間外です',
      'en': 'It\'s outside the period',
    },
    'vow996dn': {
      'ja': 'プレイ済みです',
      'en': 'Already played',
    },
    'giodltuy': {
      'ja': 'Home',
      'en': 'Home',
    },
  },
  // Tutorial
  {
    '03flc2uv': {
      'ja': '今、地震が起きたら\nどうしますか？',
      'en': 'If an earthquake happens now\nwhat should I do?',
    },
    'mu1wvlin': {
      'ja':
          '東日本大震災は、2011年3月11日に発生したマグニチュード9.0の地震とそれに伴う大規模な津波で、日本の東北地方を中心に甚大な被害をもたらしました。この自然災害によって、1万5千人以上が死亡し、数千人が行方不明となりました。\n\n地震が起きたことを想定した避難訓練が定期的に行われている日本でも、地震によって多くの被害が出ています。\n\n地震があまり起きない国の人々には地震発生時に何をすべきか分からない人も多くいます。\n\nこのアプリケーションは地震発生時に咄嗟に行動を判断できるようにするための教育ゲームです。',
      'en':
          'The Great East Japan Earthquake was a magnitude 9.0 earthquake that occurred on March 11, 2011, and the accompanying large-scale tsunami, causing extensive damage mainly in the Tohoku region of Japan. This natural disaster left more than 15,000 people dead and thousands missing.\n\nEven in Japan, where evacuation drills are regularly conducted in the event of an earthquake, earthquakes have caused a lot of damage.\n\nMany people in countries where earthquakes do not occur often do not know what to do in the event of an earthquake.\n\nThis application is an educational game that allows you to quickly decide what to do when an earthquake occurs.',
    },
    'cznbltal': {
      'ja': 'シェイクアウトとは？',
      'en': 'What is shakeout?',
    },
    '5vh18yo7': {
      'ja':
          'シェイクアウト訓練は、大規模な地震発生時の対応を想定した緊急避難訓練です。この訓練を通じて、個人、家族、学校、企業などが地震発生時の安全な行動を学び、実践することができます。',
      'en':
          'Shakeout drills are emergency evacuation drills designed to be used in the event of a large-scale earthquake. Through this training, individuals, families, schools, and businesses can learn and practice safe behavior in the event of an earthquake.',
    },
    'tw7a5d6d': {
      'ja': '「身を守る」（Drop, Cover, and Hold On)',
      'en': '“Protect yourself” (Drop, Cover, and Hold On)',
    },
    'bsbjfzub': {
      'ja':
          '地震発生時、まずは「しゃがんで」安全な場所に移動し、「頭を守る」ために机やテーブルの下などに隠れ、「しっかりと持ちこたえる」ために何かしっかりとしたものにつかまります。',
      'en':
          'When an earthquake occurs, the first thing you should do is ``squat down\'\' and move to a safe place, hide under a desk or table to ``protect your head,\'\' and hold on to something solid to ``hold on.\'\'',
    },
    '2zai0db7': {
      'ja': 'このゲームについて',
      'en': 'About this game',
    },
    'suwj84j7': {
      'ja':
          'シェイクアウトについて理解していたとしても実際に突然の地震が発生した時に咄嗟に正しい判断をして冷静な行動をすることはとても難しいです。\n\nこのゲームでは、実際に地震が発生したことを想定した突然のプッシュ通知でシェイクアウトゲームを実施することで、実際に地震が発生したときに咄嗟の判断や行動ができるように訓練ができます。\n\nまた、避難するまでのタイムでランキング上位になることで特別なアイテムが獲得できます。\n※チュートリアルやフリープレイではランキングに反映されません。\n\nそれでは、実際にゲームを開始してみましょう！',
      'en':
          'Even if you understand shakeout, it is very difficult to make the right decision and act calmly when a sudden earthquake actually occurs.\n\nIn this game, by playing a shakeout game with sudden push notifications that simulate an actual earthquake, you can train your child to make quick decisions and take actions in the event of an actual earthquake.\n\nAdditionally, you can earn special items by reaching the top of the rankings in the time it takes to evacuate.\n*Tutorials and free play will not be reflected in the rankings.\n\nNow let\'s actually start the game!',
    },
    'hl81aeg7': {
      'ja': '次へ',
      'en': 'to the next',
    },
    'x2luf449': {
      'ja': 'ゲーム開始！',
      'en': 'game start!',
    },
    'y3dkyvef': {
      'ja': 'チュートリアル',
      'en': 'tutorial',
    },
    'aggmayjp': {
      'ja': 'Home',
      'en': 'Home',
    },
  },
  // Success
  {
    'l0k24twa': {
      'ja': 'おめでとうございます！\n避難に成功しました！',
      'en': 'congratulations!\nSuccessful evacuation!',
    },
    'x8f65l8n': {
      'ja': 'タイムオーバー\n避難に失敗しました。',
      'en': 'time over\nEvacuation failed.',
    },
    'qzn7ies7': {
      'ja': '残り時間',
      'en': 'Remaining time',
    },
    '2zhjrtlu': {
      'ja': '秒',
      'en': 'seconds',
    },
    '6r6i8a2n': {
      'ja': 'Drop',
      'en': 'Drop',
    },
    'gu17p67g': {
      'ja': '秒',
      'en': 'seconds',
    },
    'ybyk62hx': {
      'ja': 'Cover',
      'en': 'Cover',
    },
    'fbmbvrfr': {
      'ja': '秒',
      'en': 'seconds',
    },
    'n36vhlvl': {
      'ja': 'Hold On',
      'en': 'Hold On',
    },
    '153rsc7v': {
      'ja': '秒',
      'en': 'seconds',
    },
    'w1wytlbo': {
      'ja':
          'フリープレイでは記録の確認のみになります。\n\nアプリの通知をオンにすると実際の地震を想定した訓練が可能で、ランキングの登録やアイテムの獲得ができます。',
      'en':
          'Free play only allows you to check your records.\n\nIf you turn on app notifications, you can train for an actual earthquake, register for rankings, and earn items.',
    },
    'c8fyc1u1': {
      'ja': '残り時間をより多く残してハイスコアを狙いましょう！\n通知がきたタイミングでゲームをクリアするとランキングにスコア反映されます。',
      'en':
          'Let\'s leave more time left and aim for a high score!\nIf you clear the game when you receive the notification, your score will be reflected in the ranking.',
    },
    '8kbstuzd': {
      'ja': '日本の被災地に寄付する',
      'en': 'Donate to disaster areas in Japan',
    },
    'r2qxf4ge': {
      'ja': 'タイトルへ',
      'en': 'go to Title',
    },
    'b0n4fwp2': {
      'ja': 'Home',
      'en': 'Home',
    },
  },
  // TopPage
  {
    '297sumt4': {
      'ja': 'シェイクアウト\nゲーム',
      'en': 'ShakeOut\nGame',
    },
    '87dm7fwb': {
      'ja': 'Tap to start',
      'en': 'Tap to start',
    },
    'w87yp6rz': {
      'ja': '© 2022 C3REVE,Inc. All Right Reserved.',
      'en': '© 2022 C3REVE,Inc. All Right Reserved.',
    },
    '91egtzsk': {
      'ja': 'Home',
      'en': 'Home',
    },
  },
  // develop_quiz
  {
    'q2lcrnoe': {
      'ja': 'Page Title',
      'en': 'Page Title',
    },
    'q7e1mrck': {
      'ja': 'Home',
      'en': 'Home',
    },
  },
  // develop_menu
  {
    'r7xmixea': {
      'ja': 'クイズ',
      'en': 'quiz',
    },
    '68nhh8k6': {
      'ja': '',
      'en': '',
    },
    'opmsi8uy': {
      'ja': 'スライダー',
      'en': 'slider',
    },
    'nd9q3b12': {
      'ja': '',
      'en': '',
    },
    'oghe6zf7': {
      'ja': 'サウンド',
      'en': 'sound',
    },
    'x4laxk78': {
      'ja': '',
      'en': '',
    },
    '6fanoipr': {
      'ja': 'ランキング',
      'en': 'Ranking',
    },
    'syr0dcb0': {
      'ja': '',
      'en': '',
    },
    'so8t28ft': {
      'ja': 'スケジュール',
      'en': 'schedule',
    },
    'sq8oxqfm': {
      'ja': '',
      'en': '',
    },
    'z29ttq7b': {
      'ja': 'チュートリアル',
      'en': 'tutorial',
    },
    '4t56x461': {
      'ja': '',
      'en': '',
    },
    'hgdzfzbl': {
      'ja': 'Develop',
      'en': 'Develop',
    },
    'zmuskhib': {
      'ja': 'Home',
      'en': 'Home',
    },
  },
  // develop_sound
  {
    'pljga3pz': {
      'ja': 'Play Audio',
      'en': 'Play Audio',
    },
    'x7irpmvs': {
      'ja': 'Stop',
      'en': 'Stop',
    },
    '9fuasr3y': {
      'ja': 'Sound',
      'en': 'Sound',
    },
    '9yawe5ek': {
      'ja': '効果音',
      'en': 'Sound effect',
    },
    'x5emcc8n': {
      'ja': 'BGM',
      'en': 'BGM',
    },
    'xive42n9': {
      'ja': 'BGMの音量',
      'en': 'BGM volume',
    },
    'bqh2jp32': {
      'ja': 'Button',
      'en': 'Button',
    },
    '3kuaqcfe': {
      'ja': 'Page Title',
      'en': 'Page Title',
    },
    'm3g13658': {
      'ja': 'Home',
      'en': 'Home',
    },
  },
  // Ranking
  {
    'dogp95en': {
      'ja': 'ランキング',
      'en': 'Ranking',
    },
    'kdfw63hu': {
      'ja': '全体',
      'en': 'whole',
    },
    'ay60wfna': {
      'ja': '自分のみ',
      'en': 'only me',
    },
    '4yn84b5t': {
      'ja': 'Home',
      'en': 'Home',
    },
  },
  // develop_slider
  {
    'fl5hzmxz': {
      'ja': 'Page Title',
      'en': 'Page Title',
    },
    'q6n7sr1a': {
      'ja': 'Home',
      'en': 'Home',
    },
  },
  // develop_schedule
  {
    'cdo2qtz6': {
      'ja': 'Page Title',
      'en': 'Page Title',
    },
    '6ndl5v4c': {
      'ja': 'Home',
      'en': 'Home',
    },
  },
  // rankingDetail
  {
    '6ioijjin': {
      'ja': 'ランキング詳細',
      'en': '',
    },
    'e2inuykw': {
      'ja': 'Home',
      'en': '',
    },
  },
  // MyItems
  {
    'r9feos2z': {
      'ja': 'マイアイテム',
      'en': '',
    },
    'u14xg4sk': {
      'ja': 'Home',
      'en': '',
    },
  },
  // ItemDetail
  {
    'mzck3q01': {
      'ja': 'レアリティ: ',
      'en': '',
    },
    'e0nnrhf7': {
      'ja': '獲得したアイテムをGoogleウォレットに追加することができます。',
      'en': '',
    },
    '6gu71bps': {
      'ja': 'アイテム詳細',
      'en': '',
    },
    'uxmeij2g': {
      'ja': 'Home',
      'en': '',
    },
  },
  // RankPointsTable
  {
    'vkl381ay': {
      'ja': 'Rank',
      'en': 'Rank',
    },
    'fxfxr9eb': {
      'ja': '456',
      'en': '456',
    },
    '8bqqhz30': {
      'ja': 'Points',
      'en': 'Points',
    },
    'ykb734if': {
      'ja': '2577',
      'en': '2577',
    },
  },
  // LBRankPointsCurrentUser
  {
    '6wdko7jv': {
      'ja': 'Rank',
      'en': 'Rank',
    },
    'jryfodht': {
      'ja': 'you',
      'en': 'you',
    },
    'yye4p0w8': {
      'ja': 'Points',
      'en': 'Points',
    },
  },
  // StepButton
  {
    'tthvyh5m': {
      'ja': 'クリア！',
      'en': 'clear!',
    },
  },
  // JustSlider
  {
    'rrfjl5w8': {
      'ja': 'スライドで頭をカバー！',
      'en': 'Cover your head with a slide!',
    },
    'bl4yig2r': {
      'ja': '0',
      'en': '0',
    },
    'mrb9g8pt': {
      'ja': '100',
      'en': '100',
    },
  },
  // DownSlider
  {
    '9o7f3ly3': {
      'ja': 'タップ',
      'en': 'Tap',
    },
    '2un4himm': {
      'ja': '円の中に入った時にタップ！',
      'en': 'Tap when it\'s inside the circle!',
    },
  },
  // QuizResult
  {
    'cckekvdk': {
      'ja': 'Q. ',
      'en': 'Q.',
    },
    'ep46nq7e': {
      'ja': 'A. ',
      'en': 'A.',
    },
  },
  // shakeOutImage
  {
    'o14rrgp6': {
      'ja': '動かない',
      'en': 'Drop',
    },
    '9zlsnkov': {
      'ja': '頭を守り',
      'en': 'Cover',
    },
    'pu9tu2ql': {
      'ja': 'まず低く',
      'en': 'Hold on',
    },
  },
  // ListItem
  {
    'x9e60k82': {
      'ja': 'レアリティ: ',
      'en': '',
    },
    'h6mj3lug': {
      'ja': '獲得日: ',
      'en': '',
    },
  },
  // Miscellaneous
  {
    'zzth9bry': {
      'ja': 'ランキングやアイテムの獲得ができるゲームは通知からのみ参加が可能です。',
      'en':
          'Games where you can earn rankings and items can only be played through notifications.',
    },
    '6s9x7osi': {
      'ja': '',
      'en': '',
    },
    'hslk6tyf': {
      'ja': '',
      'en': '',
    },
    '69s0r4y2': {
      'ja': '',
      'en': '',
    },
    'xgbycxr4': {
      'ja': '',
      'en': '',
    },
    'fq31xcjr': {
      'ja': '',
      'en': '',
    },
    'mivesvfs': {
      'ja': '',
      'en': '',
    },
    'j66mjpli': {
      'ja': '',
      'en': '',
    },
    'xevbdfw5': {
      'ja': '',
      'en': '',
    },
    'o2ndfuz0': {
      'ja': '',
      'en': '',
    },
    'kk4hkt43': {
      'ja': '',
      'en': '',
    },
    '7421565i': {
      'ja': '',
      'en': '',
    },
    '1ojfssqf': {
      'ja': '',
      'en': '',
    },
    'rfvk2nm8': {
      'ja': '',
      'en': '',
    },
    'l3pzirbt': {
      'ja': '',
      'en': '',
    },
    'bi2dp7bd': {
      'ja': '',
      'en': '',
    },
    '6vd2pu6e': {
      'ja': '',
      'en': '',
    },
    'ybde1c5b': {
      'ja': '',
      'en': '',
    },
    'z0ua3epa': {
      'ja': '',
      'en': '',
    },
    '7lwwv797': {
      'ja': '',
      'en': '',
    },
    '6llg660x': {
      'ja': '',
      'en': '',
    },
    'f7xhlqmk': {
      'ja': '',
      'en': '',
    },
    'zdmeiz91': {
      'ja': '',
      'en': '',
    },
    'ijqpwxyc': {
      'ja': '',
      'en': '',
    },
    '51ylk9bi': {
      'ja': '',
      'en': '',
    },
    '8nc9m3ti': {
      'ja': '',
      'en': '',
    },
  },
].reduce((a, b) => a..addAll(b));
