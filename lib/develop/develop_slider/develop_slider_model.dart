import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/just_slider/just_slider_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'develop_slider_widget.dart' show DevelopSliderWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DevelopSliderModel extends FlutterFlowModel<DevelopSliderWidget> {
  ///  Local state fields for this page.

  QuizzesRecord? psQuiz;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Firestore Query - Query a collection] action in develop_slider widget.
  int? quizCount;
  // Stores action output result for [Firestore Query - Query a collection] action in develop_slider widget.
  QuizzesRecord? randomQuiz;
  // Model for JustSlider component.
  late JustSliderModel justSliderModel1;
  // Model for JustSlider component.
  late JustSliderModel justSliderModel2;
  // Model for JustSlider component.
  late JustSliderModel justSliderModel3;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    justSliderModel1 = createModel(context, () => JustSliderModel());
    justSliderModel2 = createModel(context, () => JustSliderModel());
    justSliderModel3 = createModel(context, () => JustSliderModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    justSliderModel1.dispose();
    justSliderModel2.dispose();
    justSliderModel3.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
