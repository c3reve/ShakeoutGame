import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/quiz/quiz_widget.dart';
import '/components/quiz_result_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'develop_quiz_model.dart';
export 'develop_quiz_model.dart';

class DevelopQuizWidget extends StatefulWidget {
  const DevelopQuizWidget({super.key});

  @override
  State<DevelopQuizWidget> createState() => _DevelopQuizWidgetState();
}

class _DevelopQuizWidgetState extends State<DevelopQuizWidget> {
  late DevelopQuizModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DevelopQuizModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.quizCount = await queryQuizzesRecordCount();
      _model.randomQuiz = await queryQuizzesRecordOnce(
        queryBuilder: (quizzesRecord) => quizzesRecord.where(
          'no',
          isEqualTo: random_data.randomInteger(1, _model.quizCount!),
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      setState(() {
        _model.psQuiz = _model.randomQuiz;
      });
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
          child: Visibility(
            visible: _model.psQuiz != null,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 200.0,
                  decoration: BoxDecoration(),
                  child: wrapWithModel(
                    model: _model.quizModel,
                    updateCallback: () => setState(() {}),
                    child: QuizWidget(
                      quiz: _model.psQuiz!,
                      onCorrect: () async {},
                    ),
                  ),
                ),
                Container(
                  width: 200.0,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: wrapWithModel(
                    model: _model.quizResultModel,
                    updateCallback: () => setState(() {}),
                    child: QuizResultWidget(
                      quize: _model.psQuiz!,
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 20.0)),
            ),
          ),
        ),
      ),
    );
  }
}
