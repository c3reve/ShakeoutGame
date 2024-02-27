import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'quiz_model.dart';
export 'quiz_model.dart';

class QuizWidget extends StatefulWidget {
  const QuizWidget({
    super.key,
    required this.onCorrect,
    required this.quiz,
  });

  final Future Function()? onCorrect;
  final QuizzesRecord? quiz;

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> with TickerProviderStateMixin {
  late QuizModel _model;

  final animationsMap = {
    'containerOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ShakeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1000.ms,
          hz: 10,
          offset: Offset(0.0, 0.0),
          rotation: 0.087,
        ),
      ],
    ),
  };

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuizModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      unawaited(
        () async {
          await actions.playAssetSound(
            'question.mp3',
          );
        }(),
      );
    });

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AutoSizeText(
                functions.translateFromAuthLanguage(widget.quiz!.question),
                maxLines: 3,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Figtree',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 16.0,
                    ),
                minFontSize: 8.0,
              ),
              Builder(
                builder: (context) {
                  final answer = functions
                      .splitTranslate(functions
                          .translateFromAuthLanguage(widget.quiz!.answers))
                      .toList();
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: List.generate(answer.length, (answerIndex) {
                      final answerItem = answer[answerIndex];
                      return InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          if (!_model.isCorrected && !_model.showIncorrect) {
                            if (answerIndex == widget.quiz?.correct) {
                              // 正解
                              unawaited(
                                () async {
                                  await actions.playAssetSound(
                                    'question_correct.mp3',
                                  );
                                }(),
                              );
                              setState(() {
                                _model.isCorrected = true;
                              });
                              await widget.onCorrect?.call();
                            } else {
                              // 不正解
                              unawaited(
                                () async {
                                  await actions.playAssetSound(
                                    'question_Incorrect.mp3',
                                  );
                                }(),
                              );
                              setState(() {
                                _model.showIncorrect = true;
                              });
                              if (animationsMap[
                                      'containerOnActionTriggerAnimation'] !=
                                  null) {
                                await animationsMap[
                                        'containerOnActionTriggerAnimation']!
                                    .controller
                                    .forward(from: 0.0);
                              }
                              await Future.delayed(
                                  const Duration(milliseconds: 1000));
                              setState(() {
                                _model.showIncorrect = false;
                              });
                            }
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _model.isCorrected &&
                                    (answerIndex == widget.quiz?.correct)
                                ? Color(0x7F24A891)
                                : Color(0x00000000),
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Text(
                                      (answerIndex + 1).toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: AutoSizeText(
                                    answerItem,
                                    maxLines: 2,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Figtree',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 16.0,
                                        ),
                                    minFontSize: 8.0,
                                  ),
                                ),
                              ].divide(SizedBox(width: 4.0)),
                            ),
                          ),
                        ),
                      ).animateOnActionTrigger(
                        animationsMap['containerOnActionTriggerAnimation']!,
                      );
                    }).divide(SizedBox(height: 8.0)),
                  );
                },
              ),
            ].divide(SizedBox(height: 16.0)),
          ),
        ),
        if (_model.showIncorrect)
          Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Icon(
              Icons.close,
              color: FlutterFlowTheme.of(context).error,
              size: 124.0,
            ),
          ),
      ],
    );
  }
}
