// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/init_audio_player.dart';
import 'package:just_audio/just_audio.dart';

Future playAssetAudio(
  String audioFileName,
  bool isLoop,
) async {
  var _audioPlayer = AudioPlayerSingleton().audioPlayer!;

  if (_audioPlayer.playing) {
    await _audioPlayer.stop();
  }

  if (!_audioPlayer.playing) {
    if (isLoop) {
      await _audioPlayer.setLoopMode(LoopMode.all);
    }
    await _audioPlayer.setAudioSource(
      AudioSource.asset('assets/audios/${audioFileName}'),
      initialIndex: 0,
      initialPosition: Duration.zero,
    );
    await _audioPlayer.play();
  }
}
