import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
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
          Text(
            FFLocalizations.of(context).getText(
              'r49ue5br' /* Hello World */,
            ),
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              FFButtonWidget(
                onPressed: () async {
                  _model.soundPlayer2 ??= AudioPlayer();
                  if (_model.soundPlayer2!.playing) {
                    await _model.soundPlayer2!.stop();
                  }
                  _model.soundPlayer2!.setVolume(1.0);
                  _model.soundPlayer2!
                      .setAsset('assets/audios/question_correct.mp3')
                      .then((_) => _model.soundPlayer2!.play());

                  await widget.onCorrect?.call();
                },
                text: FFLocalizations.of(context).getText(
                  'aknaslnm' /* 正解 */,
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
              FFButtonWidget(
                onPressed: () async {
                  _model.soundPlayer3 ??= AudioPlayer();
                  if (_model.soundPlayer3!.playing) {
                    await _model.soundPlayer3!.stop();
                  }
                  _model.soundPlayer3!.setVolume(1.0);
                  _model.soundPlayer3!
                      .setAsset('assets/audios/question_Incorrect.mp3')
                      .then((_) => _model.soundPlayer3!.play());
                },
                text: FFLocalizations.of(context).getText(
                  'gp1mq26d' /* 不正解 */,
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
            ],
          ),
        ].divide(SizedBox(height: 8.0)),
      ),
    );
  }
}
