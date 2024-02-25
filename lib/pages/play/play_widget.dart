import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/just_slider_widget.dart';
import '/components/quiz_widget.dart';
import '/components/step_button_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'play_model.dart';
export 'play_model.dart';

class PlayWidget extends StatefulWidget {
  const PlayWidget({
    super.key,
    required this.mode,
    this.scheduleRef,
  });

  final GameMode? mode;
  final DocumentReference? scheduleRef;

  @override
  State<PlayWidget> createState() => _PlayWidgetState();
}

class _PlayWidgetState extends State<PlayWidget> with TickerProviderStateMixin {
  late PlayModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'imageOnPageLoadAnimation1': AnimationInfo(
      loop: true,
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        ShakeEffect(
          curve: Curves.bounceOut,
          delay: 0.ms,
          duration: 1000.ms,
          hz: 3,
          offset: Offset(0.0, 0.0),
          rotation: 0.017,
        ),
      ],
    ),
    'imageOnPageLoadAnimation2': AnimationInfo(
      loop: true,
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        ShakeEffect(
          curve: Curves.bounceOut,
          delay: 0.ms,
          duration: 1000.ms,
          hz: 3,
          offset: Offset(0.0, 0.0),
          rotation: 0.017,
        ),
      ],
    ),
    'imageOnPageLoadAnimation3': AnimationInfo(
      loop: true,
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        ShakeEffect(
          curve: Curves.bounceOut,
          delay: 0.ms,
          duration: 1000.ms,
          hz: 3,
          offset: Offset(0.0, 0.0),
          rotation: 0.017,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlayModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.timerController.onStartTimer();
      _model.soundPlayer ??= AudioPlayer();
      if (_model.soundPlayer!.playing) {
        await _model.soundPlayer!.stop();
      }
      _model.soundPlayer!.setVolume(0.3);
      _model.soundPlayer!
          .setAsset('assets/audios/earthquake.mp3')
          .then((_) => _model.soundPlayer!.play());

      if (widget.scheduleRef != null) {
        _model.schedule =
            await SchedulesRecord.getDocumentOnce(widget.scheduleRef!);
        _model.scheduleQuiz =
            await QuizzesRecord.getDocumentOnce(_model.schedule!.quizRef!);
        setState(() {
          _model.psQuiz = _model.scheduleQuiz;
        });
      } else {
        // クイズの総数を取得
        _model.quizCount = await queryQuizzesRecordCount();
        _model.randomQuiz = await QuizzesRecord.getDocumentOnce(
            functions.quizReferenceFromId(
                random_data.randomInteger(1, _model.quizCount!).toString()));
        setState(() {
          _model.psQuiz = _model.randomQuiz;
        });
      }

      if (_model.psNowStep == GameStep.Drop) {
        while (_model.psSliderValue! >= 0) {
          if (_model.psIsUp) {
            setState(() {
              _model.psSliderValue = _model.psSliderValue! + 1;
            });
            if (_model.psSliderValue == 100) {
              setState(() {
                _model.psIsUp = false;
              });
            }
          } else {
            setState(() {
              _model.psSliderValue = _model.psSliderValue! + -1;
            });
            if (_model.psSliderValue == 0) {
              setState(() {
                _model.psIsUp = true;
              });
            }
          }
        }
      }
      // バイブレーション繰り返し
      _model.vibrationTimer = InstantTimer.periodic(
        duration: Duration(milliseconds: 500),
        callback: (timer) async {
          await actions.vibrationCancel();
          await actions.vibration(
            500,
            null,
          );
        },
        startImmediately: true,
      );
    });

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
          actions: [
            FFButtonWidget(
              onPressed: () async {
                var confirmDialogResponse = await showDialog<bool>(
                      context: context,
                      builder: (alertDialogContext) {
                        return AlertDialog(
                          title: Text('中止'),
                          content: Text('中止すると進行中のデータは失われます。中止しますか？'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext, false),
                              child: Text('キャンセル'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext, true),
                              child: Text('中止する'),
                            ),
                          ],
                        );
                      },
                    ) ??
                    false;
                if (confirmDialogResponse) {
                  _model.vibrationTimer?.cancel();
                  _model.soundPlayer?.stop();
                  context.safePop();
                }
              },
              text: FFLocalizations.of(context).getText(
                '245emor1' /* 中止 */,
              ),
              options: FFButtonOptions(
                height: 40.0,
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
          ],
          centerTitle: true,
          elevation: 4.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 50.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlutterFlowTimer(
                      initialTime: _model.timerMilliseconds,
                      getDisplayTime: (value) => StopWatchTimer.getDisplayTime(
                        value,
                        hours: false,
                      ),
                      controller: _model.timerController,
                      updateStateInterval: Duration(milliseconds: 100),
                      onChanged: (value, displayTime, shouldUpdate) {
                        _model.timerMilliseconds = value;
                        _model.timerValue = displayTime;
                        if (shouldUpdate) setState(() {});
                      },
                      textAlign: TextAlign.start,
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: 'Figtree',
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Builder(
                        builder: (context) {
                          if (_model.psNowStep == GameStep.Drop) {
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/49svh_2.png',
                                    height: 400.0,
                                    fit: BoxFit.cover,
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'imageOnPageLoadAnimation1']!),
                                if (_model.psCanProceed)
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'wv138q5m' /* DROP を下にスワイプ！ */,
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                  ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    setState(() {
                                      _model.psCanProceed = true;
                                    });
                                  },
                                  text: FFLocalizations.of(context).getText(
                                    '9fuasr3y' /* Button */,
                                  ),
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
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
                            );
                          } else if (_model.psNowStep == GameStep.Cover) {
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/3a9k2_3.png',
                                    height: 400.0,
                                    fit: BoxFit.cover,
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'imageOnPageLoadAnimation2']!),
                                wrapWithModel(
                                  model: _model.justSliderModel,
                                  updateCallback: () => setState(() {}),
                                  child: JustSliderWidget(
                                    initialValue: valueOrDefault<int>(
                                      _model.psSliderValue,
                                      0,
                                    ),
                                    onChange: (isCorrect) async {
                                      setState(() {
                                        _model.psCanProceed = isCorrect!;
                                      });
                                    },
                                  ),
                                ),
                                if (_model.psCanProceed)
                                  Text(
                                    FFLocalizations.of(context).getText(
                                      'j3n3lhv5' /* COVER を右にスワイプ！ */,
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                  ),
                              ].divide(SizedBox(height: 20.0)),
                            );
                          } else if (_model.psNowStep == GameStep.HoldOn) {
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'assets/images/vnimc_1.png',
                                    height: 400.0,
                                    fit: BoxFit.cover,
                                  ),
                                ).animateOnPageLoad(animationsMap[
                                    'imageOnPageLoadAnimation3']!),
                                wrapWithModel(
                                  model: _model.quizModel,
                                  updateCallback: () => setState(() {}),
                                  child: QuizWidget(
                                    quiz: _model.psQuiz!,
                                    onCorrect: () async {
                                      setState(() {
                                        _model.psCanProceed = true;
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'hkh03ayt' /* HOLD ON を長押し

本当は揺れがおさまるまでにしたい... */
                                    ,
                                  ),
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                              ],
                            );
                          } else {
                            return Text(
                              '',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            );
                          }
                        },
                      ),
                    ].divide(SizedBox(height: 30.0)),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).tertiary,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          wrapWithModel(
                            model: _model.stepButtonModel1,
                            updateCallback: () => setState(() {}),
                            child: StepButtonWidget(
                              isEnable: (_model.psNowStep == GameStep.Drop) &&
                                  _model.psCanProceed,
                              isDone: _model.psDoneSteps
                                      .where((e) => e == GameStep.Drop)
                                      .toList()
                                      .length >
                                  0,
                              step: GameStep.Drop,
                              onDone: () async {
                                await _model.doneStep(
                                  context,
                                  step: _model.psNowStep,
                                );
                              },
                            ),
                          ),
                          wrapWithModel(
                            model: _model.stepButtonModel2,
                            updateCallback: () => setState(() {}),
                            child: StepButtonWidget(
                              isEnable: (_model.psNowStep == GameStep.Cover) &&
                                  _model.psCanProceed,
                              isDone: _model.psDoneSteps
                                      .where((e) => e == GameStep.Cover)
                                      .toList()
                                      .length >
                                  0,
                              step: GameStep.Cover,
                              onDone: () async {
                                await _model.doneStep(
                                  context,
                                  step: _model.psNowStep,
                                );
                              },
                            ),
                          ),
                          wrapWithModel(
                            model: _model.stepButtonModel3,
                            updateCallback: () => setState(() {}),
                            child: StepButtonWidget(
                              isEnable: (_model.psNowStep == GameStep.HoldOn) &&
                                  _model.psCanProceed,
                              isDone: _model.psDoneSteps
                                      .where((e) => e == GameStep.HoldOn)
                                      .toList()
                                      .length >
                                  0,
                              step: GameStep.HoldOn,
                              onDone: () async {
                                await _model.doneStep(
                                  context,
                                  step: _model.psNowStep,
                                );
                                _model.soundPlayer?.stop();
                                _model.vibrationTimer?.cancel();

                                context.goNamed(
                                  'Success',
                                  queryParameters: {
                                    'time': serializeParam(
                                      _model.timerMilliseconds,
                                      ParamType.int,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                            ),
                          ),
                        ].divide(SizedBox(width: 20.0)),
                      ),
                    ].divide(SizedBox(height: 20.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
