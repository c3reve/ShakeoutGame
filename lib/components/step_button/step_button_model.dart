import '/backend/schema/enums/enums.dart';
import '/components/shake_out_image_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import 'step_button_widget.dart' show StepButtonWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StepButtonModel extends FlutterFlowModel<StepButtonWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for DropCarousel widget.
  CarouselController? dropCarouselController;

  int dropCarouselCurrentIndex = 1;

  // Model for shakeOutImage component.
  late ShakeOutImageModel shakeOutImageModel1;
  // Model for shakeOutImage component.
  late ShakeOutImageModel shakeOutImageModel2;
  // Model for shakeOutImage component.
  late ShakeOutImageModel shakeOutImageModel3;
  // State field(s) for CoverCarousel widget.
  CarouselController? coverCarouselController;

  int coverCarouselCurrentIndex = 1;

  // Model for shakeOutImage component.
  late ShakeOutImageModel shakeOutImageModel4;
  // Model for shakeOutImage component.
  late ShakeOutImageModel shakeOutImageModel5;
  // Model for shakeOutImage component.
  late ShakeOutImageModel shakeOutImageModel6;
  // Model for shakeOutImage component.
  late ShakeOutImageModel shakeOutImageModel7;
  // Model for shakeOutImage component.
  late ShakeOutImageModel shakeOutImageModel8;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    shakeOutImageModel1 = createModel(context, () => ShakeOutImageModel());
    shakeOutImageModel2 = createModel(context, () => ShakeOutImageModel());
    shakeOutImageModel3 = createModel(context, () => ShakeOutImageModel());
    shakeOutImageModel4 = createModel(context, () => ShakeOutImageModel());
    shakeOutImageModel5 = createModel(context, () => ShakeOutImageModel());
    shakeOutImageModel6 = createModel(context, () => ShakeOutImageModel());
    shakeOutImageModel7 = createModel(context, () => ShakeOutImageModel());
    shakeOutImageModel8 = createModel(context, () => ShakeOutImageModel());
  }

  @override
  void dispose() {
    shakeOutImageModel1.dispose();
    shakeOutImageModel2.dispose();
    shakeOutImageModel3.dispose();
    shakeOutImageModel4.dispose();
    shakeOutImageModel5.dispose();
    shakeOutImageModel6.dispose();
    shakeOutImageModel7.dispose();
    shakeOutImageModel8.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
