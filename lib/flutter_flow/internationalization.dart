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
      'ja': '設定',
      'en': 'setting',
    },
    'xeijx7fg': {
      'ja': 'Home',
      'en': 'Home',
    },
  },
  // Settings
  {
    'y19j4wyr': {
      'ja': 'Sound',
      'en': 'Sound',
    },
    'dvjbrxng': {
      'ja': 'Music',
      'en': 'Music',
    },
    '9pd1oliu': {
      'ja': 'Vibration',
      'en': 'Vibration',
    },
    'xhaw44e7': {
      'ja': 'LEADERBOARD',
      'en': 'LEADER BOARD',
    },
    'xr2qhw6n': {
      'ja': 'Logout',
      'en': 'Logout',
    },
    'fth0uaoi': {
      'ja': 'Settings',
      'en': 'Settings',
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
      'en': '',
    },
    '2wtmfw1d': {
      'ja': 'Home',
      'en': '',
    },
  },
  // Play
  {
    '245emor1': {
      'ja': '中止',
      'en': '',
    },
    'wv138q5m': {
      'ja': 'DROP を下にスワイプ！',
      'en': '',
    },
    '9fuasr3y': {
      'ja': 'Button',
      'en': '',
    },
    'j3n3lhv5': {
      'ja': 'COVER を右にスワイプ！',
      'en': '',
    },
    'hkh03ayt': {
      'ja': 'HOLD ON を長押し\n\n本当は揺れがおさまるまでにしたいが\nボタン話したタイミングが取れないので\n一旦長押し',
      'en': '',
    },
    'giodltuy': {
      'ja': 'Home',
      'en': '',
    },
  },
  // Tutorial
  {
    'mu1wvlin': {
      'ja': '説明',
      'en': '',
    },
    'hl81aeg7': {
      'ja': 'チュートリアルを開始',
      'en': '',
    },
    'y3dkyvef': {
      'ja': 'Page Title',
      'en': '',
    },
    'aggmayjp': {
      'ja': 'Home',
      'en': '',
    },
  },
  // Success
  {
    'x8f65l8n': {
      'ja': 'おめでとう！\n避難に成功しました！',
      'en': '',
    },
    'qzn7ies7': {
      'ja': '記録',
      'en': '',
    },
    'w1wytlbo': {
      'ja':
          'ランダムでアイテム（Googleウォレットパス）を獲得\n基本的にはアカウントなしで遊べるが、アイテムの獲得やスコアランキングの登録はアカウント登録が必須。',
      'en': '',
    },
    '8kbstuzd': {
      'ja': 'Done',
      'en': '',
    },
    'b0n4fwp2': {
      'ja': 'Home',
      'en': '',
    },
  },
  // TopPage
  {
    '297sumt4': {
      'ja': 'シェイクアウト\nゲーム',
      'en': '',
    },
    '87dm7fwb': {
      'ja': 'Tap to start',
      'en': '',
    },
    'w87yp6rz': {
      'ja': '© 2022 C3REVE,Inc. All Right Reserved.',
      'en': '',
    },
    '91egtzsk': {
      'ja': 'Home',
      'en': '',
    },
  },
  // RankPointsTable
  {
    'vkl381ay': {
      'ja': 'Rank',
      'en': '',
    },
    'fxfxr9eb': {
      'ja': '456',
      'en': '',
    },
    '8bqqhz30': {
      'ja': 'Points',
      'en': '',
    },
    'ykb734if': {
      'ja': '2577',
      'en': '',
    },
  },
  // LBRankPointsCurrentUser
  {
    '6wdko7jv': {
      'ja': 'Rank',
      'en': '',
    },
    'gymf9iun': {
      'ja': '456',
      'en': '',
    },
    'yye4p0w8': {
      'ja': 'Points',
      'en': '',
    },
  },
  // LBRankPointsOtherUser
  {
    'fcb4bw72': {
      'ja': 'Rank',
      'en': '',
    },
    'h2l39c0i': {
      'ja': '456',
      'en': '',
    },
    's8dpbpdz': {
      'ja': 'Points',
      'en': '',
    },
  },
  // Quiz
  {
    'r49ue5br': {
      'ja': 'Hello World',
      'en': '',
    },
    'aknaslnm': {
      'ja': '正解',
      'en': '',
    },
    'gp1mq26d': {
      'ja': '不正解',
      'en': '',
    },
  },
  // StepButton
  {
    'tthvyh5m': {
      'ja': 'クリア！',
      'en': '',
    },
  },
  // JustSlider
  {
    'bl4yig2r': {
      'ja': '0',
      'en': '',
    },
    'mrb9g8pt': {
      'ja': '100',
      'en': '',
    },
  },
  // Miscellaneous
  {
    'zzth9bry': {
      'ja': 'ランキングやアイテムの獲得ができるゲームは通知からのみ参加が可能です。',
      'en': '',
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
