import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'down_slider_model.dart';
export 'down_slider_model.dart';

class DownSliderWidget extends StatefulWidget {
  const DownSliderWidget({
    super.key,
    required this.onInitialized,
  });

  final Future Function(bool? isCollect)? onInitialized;

  @override
  State<DownSliderWidget> createState() => _DownSliderWidgetState();
}

class _DownSliderWidgetState extends State<DownSliderWidget> {
  late DownSliderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DownSliderModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.instantTimer = InstantTimer.periodic(
        duration: Duration(milliseconds: 50),
        callback: (timer) async {
          if (_model.csIsUp!) {
            if (_model.csSliderValue! <= -1.0) {
              setState(() {
                _model.csSliderValue = _model.csSliderValue! + 0.1;
              });
              setState(() {
                _model.csIsUp = false;
              });
            } else {
              setState(() {
                _model.csSliderValue = _model.csSliderValue! + -0.1;
              });
            }
          } else {
            if (_model.csSliderValue! >= 1.0) {
              setState(() {
                _model.csSliderValue = _model.csSliderValue! + -0.1;
              });
              setState(() {
                _model.csIsUp = true;
              });
            } else {
              setState(() {
                _model.csSliderValue = _model.csSliderValue! + 0.1;
              });
            }
          }
        },
        startImmediately: true,
      );
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

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 100.0,
          height: 300.0,
          decoration: BoxDecoration(
            color: Color(0x00FFFFFF),
          ),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(
                    0.0,
                    valueOrDefault<double>(
                      _model.csSliderValue,
                      0.0,
                    )),
                child: Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Color(0x00FFFFFF),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).secondary,
                      width: 4.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        FFButtonWidget(
          onPressed: _model.isDisable
              ? null
              : () async {
                  if ((_model.csSliderValue! >= 0.8) &&
                      (_model.csSliderValue! <= 1.00)) {
                    _model.instantTimer?.cancel();
                    await widget.onInitialized?.call(
                      true,
                    );
                    setState(() {
                      _model.isDisable = true;
                    });
                  } else {
                    setState(() {
                      _model.csSliderValue = -1.0;
                    });
                  }
                },
          text: FFLocalizations.of(context).getText(
            '9o7f3ly3' /* タップ */,
          ),
          options: FFButtonOptions(
            height: 40.0,
            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
            disabledColor: FlutterFlowTheme.of(context).secondaryText,
          ),
        ),
        Text(
          FFLocalizations.of(context).getText(
            '2un4himm' /* 円の中に入った時にタップ！ */,
          ),
          style: FlutterFlowTheme.of(context).bodyMedium,
        ),
      ].divide(SizedBox(height: 8.0)),
    );
  }
}
