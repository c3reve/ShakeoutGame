import '/backend/schema/enums/enums.dart';
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

  // State field(s) for CoverCarousel widget.
  CarouselController? coverCarouselController;

  int coverCarouselCurrentIndex = 1;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
