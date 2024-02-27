import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _playerName = prefs.getString('ff_playerName') ?? _playerName;
    });
    _safeInit(() {
      _isDarkMode = prefs.getBool('ff_isDarkMode') ?? _isDarkMode;
    });
    _safeInit(() {
      _lastAchievedLevel =
          prefs.getInt('ff_lastAchievedLevel') ?? _lastAchievedLevel;
    });
    _safeInit(() {
      _isVibrationAllowed =
          prefs.getBool('ff_isVibrationAllowed') ?? _isVibrationAllowed;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _playerName = 'player1';
  String get playerName => _playerName;
  set playerName(String _value) {
    _playerName = _value;
    prefs.setString('ff_playerName', _value);
  }

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  set isDarkMode(bool _value) {
    _isDarkMode = _value;
    prefs.setBool('ff_isDarkMode', _value);
  }

  int _levelsCount = 5;
  int get levelsCount => _levelsCount;
  set levelsCount(int _value) {
    _levelsCount = _value;
  }

  int _lastAchievedLevel = 0;
  int get lastAchievedLevel => _lastAchievedLevel;
  set lastAchievedLevel(int _value) {
    _lastAchievedLevel = _value;
    prefs.setInt('ff_lastAchievedLevel', _value);
  }

  List<PlayerStruct> _currentPlayers = [];
  List<PlayerStruct> get currentPlayers => _currentPlayers;
  set currentPlayers(List<PlayerStruct> _value) {
    _currentPlayers = _value;
  }

  void addToCurrentPlayers(PlayerStruct _value) {
    _currentPlayers.add(_value);
  }

  void removeFromCurrentPlayers(PlayerStruct _value) {
    _currentPlayers.remove(_value);
  }

  void removeAtIndexFromCurrentPlayers(int _index) {
    _currentPlayers.removeAt(_index);
  }

  void updateCurrentPlayersAtIndex(
    int _index,
    PlayerStruct Function(PlayerStruct) updateFn,
  ) {
    _currentPlayers[_index] = updateFn(_currentPlayers[_index]);
  }

  void insertAtIndexInCurrentPlayers(int _index, PlayerStruct _value) {
    _currentPlayers.insert(_index, _value);
  }

  bool _isHapticAllowed = true;
  bool get isHapticAllowed => _isHapticAllowed;
  set isHapticAllowed(bool _value) {
    _isHapticAllowed = _value;
  }

  bool _isSoundOn = true;
  bool get isSoundOn => _isSoundOn;
  set isSoundOn(bool _value) {
    _isSoundOn = _value;
  }

  String _musicFile =
      'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3';
  String get musicFile => _musicFile;
  set musicFile(String _value) {
    _musicFile = _value;
  }

  double _currentMusicVolume = 0.5;
  double get currentMusicVolume => _currentMusicVolume;
  set currentMusicVolume(double _value) {
    _currentMusicVolume = _value;
  }

  bool _isVibrationAllowed = true;
  bool get isVibrationAllowed => _isVibrationAllowed;
  set isVibrationAllowed(bool _value) {
    _isVibrationAllowed = _value;
    prefs.setBool('ff_isVibrationAllowed', _value);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
