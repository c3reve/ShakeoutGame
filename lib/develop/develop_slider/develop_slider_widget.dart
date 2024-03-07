import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/decimal_time_widget.dart';
import '/components/just_slider/just_slider_widget.dart';
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
import 'develop_slider_model.dart';
export 'develop_slider_model.dart';

class DevelopSliderWidget extends StatefulWidget {
  const DevelopSliderWidget({super.key});

  @override
  State<DevelopSliderWidget> createState() => _DevelopSliderWidgetState();
}

class _DevelopSliderWidgetState extends State<DevelopSliderWidget> {
  late DevelopSliderModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DevelopSliderModel());

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
              'fl5hzmxz' /* Page Title */,
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
              wrapWithModel(
                model: _model.justSliderModel1,
                updateCallback: () => setState(() {}),
                child: JustSliderWidget(
                  correct: 0.0,
                  onChange: (isCorrect) async {},
                ),
              ),
              wrapWithModel(
                model: _model.justSliderModel2,
                updateCallback: () => setState(() {}),
                child: JustSliderWidget(
                  correct: 50.0,
                  onChange: (isCorrect) async {},
                ),
              ),
              wrapWithModel(
                model: _model.justSliderModel3,
                updateCallback: () => setState(() {}),
                child: JustSliderWidget(
                  correct: 100.0,
                  onChange: (isCorrect) async {},
                ),
              ),
              Expanded(
                child: wrapWithModel(
                  model: _model.decimalTimeModel1,
                  updateCallback: () => setState(() {}),
                  child: DecimalTimeWidget(
                    time: 1.2345,
                    fontSize: 32.0,
                  ),
                ),
              ),
              Expanded(
                child: wrapWithModel(
                  model: _model.decimalTimeModel2,
                  updateCallback: () => setState(() {}),
                  child: DecimalTimeWidget(
                    time: 1234.5,
                  ),
                ),
              ),
            ].divide(SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }
}
