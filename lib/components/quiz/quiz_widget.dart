import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
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

class _QuizWidgetState extends State<QuizWidget> {
  late QuizModel _model;

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
      _model.soundPlayer1 ??= AudioPlayer();
      if (_model.soundPlayer1!.playing) {
        await _model.soundPlayer1!.stop();
      }
      _model.soundPlayer1!.setVolume(1.0);
      _model.soundPlayer1!
          .setAsset('assets/audios/question.mp3')
          .then((_) => _model.soundPlayer1!.play());
    });

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

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
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
                  .splitTranslate(
                      functions.translateFromAuthLanguage(widget.quiz!.answers))
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
                      if (answerIndex == widget.quiz?.correct) {
                        // 正解
                        _model.soundPlayer2 ??= AudioPlayer();
                        if (_model.soundPlayer2!.playing) {
                          await _model.soundPlayer2!.stop();
                        }
                        _model.soundPlayer2!.setVolume(1.0);
                        _model.soundPlayer2!
                            .setAsset('assets/audios/question_correct.mp3')
                            .then((_) => _model.soundPlayer2!.play());

                        setState(() {
                          _model.insertAtIndexInCsContainerColor(answerIndex,
                              FlutterFlowTheme.of(context).success);
                        });
                        await widget.onCorrect?.call();
                      } else {
                        // 不正解
                        _model.soundPlayer3 ??= AudioPlayer();
                        if (_model.soundPlayer3!.playing) {
                          await _model.soundPlayer3!.stop();
                        }
                        _model.soundPlayer3!.setVolume(1.0);
                        _model.soundPlayer3!
                            .setAsset('assets/audios/question_Incorrect.mp3')
                            .then((_) => _model.soundPlayer3!.play());

                        setState(() {
                          _model.insertAtIndexInCsContainerColor(
                              answerIndex, FlutterFlowTheme.of(context).error);
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _model.csContainerColor[answerIndex],
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
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
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
                  );
                }).divide(SizedBox(height: 8.0)),
              );
            },
          ),
        ].divide(SizedBox(height: 16.0)),
      ),
    );
  }
}
