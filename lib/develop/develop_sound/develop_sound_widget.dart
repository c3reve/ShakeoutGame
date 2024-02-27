import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'develop_sound_model.dart';
export 'develop_sound_model.dart';

class DevelopSoundWidget extends StatefulWidget {
  const DevelopSoundWidget({super.key});

  @override
  State<DevelopSoundWidget> createState() => _DevelopSoundWidgetState();
}

class _DevelopSoundWidgetState extends State<DevelopSoundWidget> {
  late DevelopSoundModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DevelopSoundModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'q2lcrnoe' /* Page Title */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Figtree',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      unawaited(
                        () async {
                          await actions.playAssetAudio(
                            'cover.mp3',
                            true,
                          );
                        }(),
                      );
                    },
                    text: FFLocalizations.of(context).getText(
                      'pljga3pz' /* Play Audio */,
                    ),
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Figtree',
                                color: Colors.white,
                              ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      unawaited(
                        () async {
                          await actions.stopAudio();
                        }(),
                      );
                    },
                    text: FFLocalizations.of(context).getText(
                      'x7irpmvs' /* Stop */,
                    ),
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Figtree',
                                color: Colors.white,
                              ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              ),
              FFButtonWidget(
                onPressed: () async {
                  unawaited(
                    () async {
                      await actions.playAssetSound(
                        'drop.mp3',
                      );
                    }(),
                  );
                },
                text: FFLocalizations.of(context).getText(
                  '9fuasr3y' /* Sound */,
                ),
                options: FFButtonOptions(
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Figtree',
                        color: Colors.white,
                      ),
                  elevation: 3.0,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).tertiary,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            FFLocalizations.of(context).getText(
                              '9yawe5ek' /* 効果音 */,
                            ),
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Rubik',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(1.0, 0.0),
                            child: Switch.adaptive(
                              value: _model.musicSwitchValue1 ??=
                                  FFAppState().isSoundOn,
                              onChanged: (newValue) async {
                                setState(
                                    () => _model.musicSwitchValue1 = newValue!);
                                if (newValue!) {
                                  setState(() {
                                    FFAppState().isSoundOn = true;
                                  });
                                } else {
                                  setState(() {
                                    FFAppState().isSoundOn = false;
                                  });
                                }
                              },
                              activeColor: FlutterFlowTheme.of(context).primary,
                              activeTrackColor:
                                  FlutterFlowTheme.of(context).accent1,
                              inactiveTrackColor:
                                  FlutterFlowTheme.of(context).accent1,
                              inactiveThumbColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'x5emcc8n' /* BGM */,
                            ),
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Rubik',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional(1.0, 0.0),
                            child: Switch.adaptive(
                              value: _model.musicSwitchValue2 ??=
                                  FFAppState().isBgmOn,
                              onChanged: (newValue) async {
                                setState(
                                    () => _model.musicSwitchValue2 = newValue!);
                                if (newValue!) {
                                  setState(() {
                                    FFAppState().isBgmOn = true;
                                  });
                                } else {
                                  setState(() {
                                    FFAppState().isBgmOn = false;
                                  });
                                  await actions.stopAudio();
                                }
                              },
                              activeColor: FlutterFlowTheme.of(context).primary,
                              activeTrackColor:
                                  FlutterFlowTheme.of(context).accent1,
                              inactiveTrackColor:
                                  FlutterFlowTheme.of(context).accent1,
                              inactiveThumbColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'xive42n9' /* BGMの音量 */,
                            ),
                            textAlign: TextAlign.start,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Rubik',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                            showValueIndicator: ShowValueIndicator.always,
                          ),
                          child: Slider(
                            activeColor: FlutterFlowTheme.of(context).primary,
                            inactiveColor: FlutterFlowTheme.of(context).primary,
                            min: 0.0,
                            max: 1.0,
                            value: _model.soundSliderValue ??=
                                valueOrDefault<double>(
                              FFAppState().currentMusicVolume,
                              0.5,
                            ),
                            label: _model.soundSliderValue.toString(),
                            onChanged: (newValue) {
                              newValue =
                                  double.parse(newValue.toStringAsFixed(1));
                              setState(
                                  () => _model.soundSliderValue = newValue);
                            },
                            onChangeEnd: (newValue) async {
                              newValue =
                                  double.parse(newValue.toStringAsFixed(1));
                              setState(
                                  () => _model.soundSliderValue = newValue);
                              await actions.adjustMusicVolume(
                                _model.soundSliderValue!,
                              );
                              setState(() {
                                FFAppState().currentMusicVolume =
                                    _model.soundSliderValue!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      _model.soundPlayer1 ??= AudioPlayer();
                      if (_model.soundPlayer1!.playing) {
                        await _model.soundPlayer1!.stop();
                      }
                      _model.soundPlayer1!.setVolume(1.0);
                      _model.soundPlayer1!
                          .setAsset('assets/audios/drop.mp3')
                          .then((_) => _model.soundPlayer1!.play());

                      _model.soundPlayer2 ??= AudioPlayer();
                      if (_model.soundPlayer2!.playing) {
                        await _model.soundPlayer2!.stop();
                      }
                      _model.soundPlayer2!.setVolume(1.0);
                      _model.soundPlayer2!
                          .setAsset('assets/audios/cover.mp3')
                          .then((_) => _model.soundPlayer2!.play());

                      _model.soundPlayer3 ??= AudioPlayer();
                      if (_model.soundPlayer3!.playing) {
                        await _model.soundPlayer3!.stop();
                      }
                      _model.soundPlayer3!.setVolume(1.0);
                      _model.soundPlayer3!
                          .setAsset('assets/audios/question.mp3')
                          .then((_) => _model.soundPlayer3!.play());

                      _model.soundPlayer4 ??= AudioPlayer();
                      if (_model.soundPlayer4!.playing) {
                        await _model.soundPlayer4!.stop();
                      }
                      _model.soundPlayer4!.setVolume(1.0);
                      _model.soundPlayer4!
                          .setAsset('assets/audios/success.mp3')
                          .then((_) => _model.soundPlayer4!.play());

                      _model.soundPlayer5 ??= AudioPlayer();
                      if (_model.soundPlayer5!.playing) {
                        await _model.soundPlayer5!.stop();
                      }
                      _model.soundPlayer5!.setVolume(1.0);
                      _model.soundPlayer5!
                          .setAsset('assets/audios/question_correct.mp3')
                          .then((_) => _model.soundPlayer5!.play());

                      _model.soundPlayer6 ??= AudioPlayer();
                      if (_model.soundPlayer6!.playing) {
                        await _model.soundPlayer6!.stop();
                      }
                      _model.soundPlayer6!.setVolume(1.0);
                      _model.soundPlayer6!
                          .setAsset('assets/audios/question_Incorrect.mp3')
                          .then((_) => _model.soundPlayer6!.play());

                      _model.soundPlayer7 ??= AudioPlayer();
                      if (_model.soundPlayer7!.playing) {
                        await _model.soundPlayer7!.stop();
                      }
                      _model.soundPlayer7!.setVolume(1.0);
                      _model.soundPlayer7!
                          .setAsset('assets/audios/earthquake.mp3')
                          .then((_) => _model.soundPlayer7!.play());
                    },
                    text: FFLocalizations.of(context).getText(
                      'bqh2jp32' /* Button */,
                    ),
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Figtree',
                                color: Colors.white,
                              ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
