import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/down_slider_widget.dart';
import '/components/just_slider/just_slider_widget.dart';
import '/components/quiz/quiz_widget.dart';
import '/components/step_button/step_button_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
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
      if (widget.scheduleRef != null) {
        // スケジュール取得
        _model.schedule =
            await SchedulesRecord.getDocumentOnce(widget.scheduleRef!);
        // スケジュールのクイズ取得
        _model.scheduleQuiz =
            await QuizzesRecord.getDocumentOnce(_model.schedule!.quizRef!);
        if (((_model.schedule?.startTime != null) &&
                (_model.schedule!.startTime! <= getCurrentTimestamp)) &&
            ((_model.schedule?.endTime != null) &&
                (getCurrentTimestamp < _model.schedule!.endTime!))) {
          // スコア取得
          _model.aoScore = await queryScoresRecordOnce(
            queryBuilder: (scoresRecord) => scoresRecord
                .where(
                  'userRef',
                  isEqualTo: currentUserReference,
                )
                .where(
                  'scheduleRef',
                  isEqualTo: widget.scheduleRef,
                ),
            singleRecord: true,
          ).then((s) => s.firstOrNull);
          if (!(_model.aoScore?.reference == null)) {
            setState(() {
              _model.psPlayError = PlayError.Played;
            });
            await _model.invalidPlay(context);
            return;
          }
        } else {
          setState(() {
            _model.psPlayError = PlayError.OutOfTerm;
          });
          await _model.invalidPlay(context);
          return;
        }

        // Check OK
        setState(() {
          _model.psQuiz = _model.scheduleQuiz;
          _model.psIsPageLoaded = true;
        });
      } else {
        // クイズ数を取得
        _model.quizCount = await queryQuizzesRecordCount();
        // ランダムでクイズを取得
        _model.randomQuiz = await queryQuizzesRecordOnce(
          queryBuilder: (quizzesRecord) => quizzesRecord.where(
            'no',
            isEqualTo: random_data.randomInteger(1, _model.quizCount!),
          ),
          singleRecord: true,
        ).then((s) => s.firstOrNull);
        setState(() {
          _model.psQuiz = _model.randomQuiz;
          _model.psIsPageLoaded = true;
        });
      }

      // BGM再生
      unawaited(
        () async {
          await actions.playAssetAudio(
            'earthquake.mp3',
            true,
          );
        }(),
      );
      // スコア計測開始
      _model.scoreTimerController.onStartTimer();
      if (!isWeb && FFAppState().isVibrationAllowed) {
        // バイブレーション繰り返し
        _model.vibrationTimer = InstantTimer.periodic(
          duration: Duration(milliseconds: 1000),
          callback: (timer) async {
            await actions.vibrationCancel();
            await actions.vibration(
              500,
              null,
            );
          },
          startImmediately: true,
        );
      }
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
                  unawaited(
                    () async {
                      await actions.stopAudio();
                    }(),
                  );
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
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              constraints: BoxConstraints(
                maxWidth: FFAppConstants.ContentMaxWidth,
              ),
              decoration: BoxDecoration(),
              child: Builder(
                builder: (context) {
                  if (_model.psIsPageLoaded && (_model.psPlayError == null)) {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlutterFlowTimer(
                                initialTime: _model.scoreTimerMilliseconds,
                                getDisplayTime: (value) =>
                                    StopWatchTimer.getDisplayTime(
                                  value,
                                  hours: false,
                                  minute: false,
                                ),
                                controller: _model.scoreTimerController,
                                updateStateInterval:
                                    Duration(milliseconds: 100),
                                onChanged: (value, displayTime, shouldUpdate) {
                                  _model.scoreTimerMilliseconds = value;
                                  _model.scoreTimerValue = displayTime;
                                  if (shouldUpdate) setState(() {});
                                },
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
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
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Builder(
                                    builder: (context) {
                                      if (_model.psNowStep == GameStep.Drop) {
                                        return Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/49svh_2.png',
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                                'imageOnPageLoadAnimation1']!),
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Color(0xB3FFFFFF),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'xvn18l2d' /* 地震が発生したら体勢を低くして地面に近づきましょう。 */,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge,
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: wrapWithModel(
                                                        model: _model
                                                            .downSliderModel,
                                                        updateCallback: () =>
                                                            setState(() {}),
                                                        child: DownSliderWidget(
                                                          onInitialized:
                                                              (isCollect) async {
                                                            setState(() {
                                                              _model.psCanProceed =
                                                                  isCollect!;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else if (_model.psNowStep ==
                                          GameStep.Cover) {
                                        return Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/3a9k2_3.png',
                                                width: double.infinity,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                                'imageOnPageLoadAnimation2']!),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xB3FFFFFF),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'kpohh8hb' /* 固定されたデスクやテーブルの下に入り、頭を守りましょう。
頭... */
                                                        ,
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyLarge,
                                                    ),
                                                    wrapWithModel(
                                                      model: _model
                                                          .justSliderModel,
                                                      updateCallback: () =>
                                                          setState(() {}),
                                                      child: JustSliderWidget(
                                                        onChange:
                                                            (isCorrect) async {
                                                          setState(() {
                                                            _model.psCanProceed =
                                                                isCorrect!;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 20.0)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else if (_model.psNowStep ==
                                          GameStep.HoldOn) {
                                        return Stack(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, -1.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/vnimc_1.png',
                                                  width: double.infinity,
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ).animateOnPageLoad(animationsMap[
                                                  'imageOnPageLoadAnimation3']!),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, 1.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xB3FFFFFF),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(16.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'fnmlbbtm' /* 揺れが止まるまで動かずじっとしていましょう。 */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge,
                                                      ),
                                                      wrapWithModel(
                                                        model: _model.quizModel,
                                                        updateCallback: () =>
                                                            setState(() {}),
                                                        child: QuizWidget(
                                                          quiz: _model.psQuiz!,
                                                          onCorrect: () async {
                                                            setState(() {
                                                              _model.psCanProceed =
                                                                  true;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 20.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Text(
                                          '',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium,
                                        );
                                      }
                                    },
                                  ),
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
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 22.0,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Visibility(
                                    visible: _model.psCanProceed,
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Builder(
                                        builder: (context) {
                                          if (_model.psNowStep ==
                                              GameStep.Drop) {
                                            return Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '2z6gscgr' /* DROPを下にスワイプ！ */,
                                              ),
                                              textAlign: TextAlign.center,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Figtree',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        fontSize: 16.0,
                                                      ),
                                            );
                                          } else if (_model.psNowStep ==
                                              GameStep.Cover) {
                                            return Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'rtq7r6xo' /* COVERを右にスワイプ！ */,
                                              ),
                                              textAlign: TextAlign.center,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Figtree',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        fontSize: 16.0,
                                                      ),
                                            );
                                          } else {
                                            return Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '6eq3vrfr' /* HOLD ONを長押し！ */,
                                              ),
                                              textAlign: TextAlign.center,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Figtree',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        fontSize: 16.0,
                                                      ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    wrapWithModel(
                                      model: _model.stepButtonModel1,
                                      updateCallback: () => setState(() {}),
                                      child: StepButtonWidget(
                                        isEnable: (_model.psNowStep ==
                                                GameStep.Drop) &&
                                            _model.psCanProceed,
                                        isDone: _model.psDoneSteps
                                                .where(
                                                    (e) => e == GameStep.Drop)
                                                .toList()
                                                .length >
                                            0,
                                        step: GameStep.Drop,
                                        onDone: () async {
                                          await _model.doneStep(
                                            context,
                                            step: _model.psNowStep,
                                          );
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    wrapWithModel(
                                      model: _model.stepButtonModel2,
                                      updateCallback: () => setState(() {}),
                                      child: StepButtonWidget(
                                        isEnable: (_model.psNowStep ==
                                                GameStep.Cover) &&
                                            _model.psCanProceed,
                                        isDone: _model.psDoneSteps
                                                .where(
                                                    (e) => e == GameStep.Cover)
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
                                        isEnable: (_model.psNowStep ==
                                                GameStep.HoldOn) &&
                                            _model.psCanProceed,
                                        isDone: _model.psDoneSteps
                                                .where(
                                                    (e) => e == GameStep.HoldOn)
                                                .toList()
                                                .length >
                                            0,
                                        step: GameStep.HoldOn,
                                        onDone: () async {
                                          _model.scoreTimerController
                                              .onStopTimer();
                                          await _model.doneStep(
                                            context,
                                            step: _model.psNowStep,
                                          );
                                          unawaited(
                                            () async {
                                              await actions.stopAudio();
                                            }(),
                                          );
                                          _model.vibrationTimer?.cancel();
                                          if (widget.scheduleRef != null) {
                                            var scoresRecordReference =
                                                ScoresRecord.collection.doc();
                                            await scoresRecordReference.set({
                                              ...createScoresRecordData(
                                                userRef: currentUserReference,
                                                scheduleRef: widget.scheduleRef,
                                                time: _model
                                                    .scoreTimerMilliseconds,
                                                score: updateScoreSetStruct(
                                                  _model.psScore,
                                                  clearUnsetFields: false,
                                                  create: true,
                                                ),
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'created_time': FieldValue
                                                      .serverTimestamp(),
                                                },
                                              ),
                                            });
                                            _model.aoCreatedScore = ScoresRecord
                                                .getDocumentFromData({
                                              ...createScoresRecordData(
                                                userRef: currentUserReference,
                                                scheduleRef: widget.scheduleRef,
                                                time: _model
                                                    .scoreTimerMilliseconds,
                                                score: updateScoreSetStruct(
                                                  _model.psScore,
                                                  clearUnsetFields: false,
                                                  create: true,
                                                ),
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'created_time':
                                                      DateTime.now(),
                                                },
                                              ),
                                            }, scoresRecordReference);

                                            context.goNamed(
                                              'Success',
                                              queryParameters: {
                                                'time': serializeParam(
                                                  _model.scoreTimerMilliseconds,
                                                  ParamType.int,
                                                ),
                                                'mode': serializeParam(
                                                  widget.mode,
                                                  ParamType.Enum,
                                                ),
                                                'quizeDoc': serializeParam(
                                                  _model.psQuiz,
                                                  ParamType.Document,
                                                ),
                                                'scoreDoc': serializeParam(
                                                  _model.aoCreatedScore,
                                                  ParamType.Document,
                                                ),
                                                'score': serializeParam(
                                                  _model.psScore?.toMap(),
                                                  ParamType.JSON,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                'quizeDoc': _model.psQuiz,
                                                'scoreDoc':
                                                    _model.aoCreatedScore,
                                              },
                                            );
                                          } else {
                                            context.goNamed(
                                              'Success',
                                              queryParameters: {
                                                'time': serializeParam(
                                                  _model.scoreTimerMilliseconds,
                                                  ParamType.int,
                                                ),
                                                'mode': serializeParam(
                                                  widget.mode,
                                                  ParamType.Enum,
                                                ),
                                                'quizeDoc': serializeParam(
                                                  _model.psQuiz,
                                                  ParamType.Document,
                                                ),
                                                'score': serializeParam(
                                                  _model.psScore?.toMap(),
                                                  ParamType.JSON,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                'quizeDoc': _model.psQuiz,
                                              },
                                            );
                                          }

                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 20.0)),
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Builder(
                              builder: (context) {
                                if (_model.psPlayError == PlayError.OutOfTerm) {
                                  return Text(
                                    FFLocalizations.of(context).getText(
                                      '4hl9up9h' /* 期間外です */,
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                  );
                                } else if (_model.psPlayError ==
                                    PlayError.Played) {
                                  return Text(
                                    FFLocalizations.of(context).getText(
                                      'vow996dn' /* プレイ済みです */,
                                    ),
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                  );
                                } else {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          if (!_model.psIsPageLoaded)
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Container(
                                width: 32.0,
                                height: 32.0,
                                child: custom_widgets.LoadingSpinner(
                                  width: 32.0,
                                  height: 32.0,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
