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
      'en': 'ShakeOut\nGame',
    },
    '45xdkaj0': {
      'ja': 'はじめる',
      'en': 'Play',
    },
    'naw8gn6b': {
      'ja': 'ランキング',
      'en': 'Ranking',
    },
    'hf1hdpl1': {
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
    'bxfo3361': {
      'ja': 'ランキング',
      'en': 'LEADER BOARD',
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
    'xvn18l2d': {
      'ja': '地震が発生したら体勢を低くして地面に近づきましょう。',
      'en': 'If an earthquake occurs, stay low and get close to the ground.',
    },
    'kpohh8hb': {
      'ja': '固定されたデスクやテーブルの下に入り、頭を守りましょう。\n頭を守るものがない場合は、腕や荷物を使って、頭を守りましょう。',
      'en':
          'Protect your head by getting under a fixed desk or table.\nIf you don\'t have something to protect your head, use your arms or luggage to protect your head.',
    },
    'fnmlbbtm': {
      'ja': '揺れが止まるまで動かずじっとしていましょう。',
      'en': 'Stay still and do not move until the shaking stops.',
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
      'ja': 'シェイクアウトとは？',
      'en': 'What is shakeout?',
    },
    'mu1wvlin': {
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
          'When an earthquake occurs, the first thing you should do is ``squat\'\' and move to a safe place, hide under a desk or table to ``protect your head,\'\' and hold on to something solid to ``hold on.\'\'',
    },
    'hl81aeg7': {
      'ja': 'チュートリアルを開始',
      'en': 'Start tutorial',
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
    'x8f65l8n': {
      'ja': 'おめでとうございます！\n避難に成功しました！',
      'en': 'Congratulations!\nSuccessful evacuation!',
    },
    'qzn7ies7': {
      'ja': '記録',
      'en': 'record',
    },
    '2zhjrtlu': {
      'ja': '秒',
      'en': 'seconds',
    },
    '6r6i8a2n': {
      'ja': 'Drop',
      'en': '',
    },
    'gu17p67g': {
      'ja': '秒',
      'en': '',
    },
    'ybyk62hx': {
      'ja': 'Cover',
      'en': '',
    },
    'fbmbvrfr': {
      'ja': '秒',
      'en': '',
    },
    'n36vhlvl': {
      'ja': 'Hold On',
      'en': '',
    },
    '153rsc7v': {
      'ja': '秒',
      'en': '',
    },
    'w1wytlbo': {
      'ja':
          'フリープレイでは記録の確認のみになります。\n\nアプリの通知をオンにすると実際の地震を想定した訓練が可能で、ランキングの登録やアイテムの獲得ができます。',
      'en':
          'Free play only allows you to check your records.\n\nIf you turn on app notifications, you can train for an actual earthquake, register for rankings, and earn items.',
    },
    '8kbstuzd': {
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
      'en': '',
    },
    'sq8oxqfm': {
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
      'en': '',
    },
    'x5emcc8n': {
      'ja': 'BGM',
      'en': '',
    },
    'xive42n9': {
      'ja': 'BGMの音量',
      'en': '',
    },
    'bqh2jp32': {
      'ja': 'Button',
      'en': '',
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
      'en': '',
    },
    '4yn84b5t': {
      'ja': 'Home',
      'en': '',
    },
  },
  // develop_slider
  {
    'fl5hzmxz': {
      'ja': 'Page Title',
      'en': '',
    },
    'q6n7sr1a': {
      'ja': 'Home',
      'en': '',
    },
  },
  // develop_schedule
  {
    'cdo2qtz6': {
      'ja': 'Page Title',
      'en': '',
    },
    '6ndl5v4c': {
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
      'en': '',
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
  // emptyText
  {
    'wsc4ut3d': {
      'ja': 'まだランキングが記録されていません',
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
