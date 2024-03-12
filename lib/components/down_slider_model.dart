import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import 'down_slider_widget.dart' show DownSliderWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DownSliderModel extends FlutterFlowModel<DownSliderWidget> {
  ///  Local state fields for this component.

  double? csSliderValue = 0.0;

  bool? csIsUp = true;

  bool isDisable = false;

  ///  State fields for stateful widgets in this component.

  InstantTimer? DropTimer;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    DropTimer?.cancel();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
