import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/shake_out_image_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'main_menu_widget.dart' show MainMenuWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainMenuModel extends FlutterFlowModel<MainMenuWidget> {
  ///  Local state fields for this page.

  bool musicEnabled = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - getLanguageCode] action in MainMenu widget.
  String? aoLanguage;
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
