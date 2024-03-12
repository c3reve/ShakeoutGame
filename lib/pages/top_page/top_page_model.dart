import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/shake_out_image_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'top_page_widget.dart' show TopPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TopPageModel extends FlutterFlowModel<TopPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for shakeOutImage component.
  late ShakeOutImageModel shakeOutImageModel1;
  // Model for shakeOutImage component.
  late ShakeOutImageModel shakeOutImageModel2;
  // Model for shakeOutImage component.
  late ShakeOutImageModel shakeOutImageModel3;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    shakeOutImageModel1 = createModel(context, () => ShakeOutImageModel());
    shakeOutImageModel2 = createModel(context, () => ShakeOutImageModel());
    shakeOutImageModel3 = createModel(context, () => ShakeOutImageModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    shakeOutImageModel1.dispose();
    shakeOutImageModel2.dispose();
    shakeOutImageModel3.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
