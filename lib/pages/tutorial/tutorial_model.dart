import '/backend/schema/enums/enums.dart';
import '/components/shake_out_image_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'tutorial_widget.dart' show TutorialWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TutorialModel extends FlutterFlowModel<TutorialWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
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
