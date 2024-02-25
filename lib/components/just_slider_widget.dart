import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'just_slider_model.dart';
export 'just_slider_model.dart';

class JustSliderWidget extends StatefulWidget {
  const JustSliderWidget({
    super.key,
    required this.onChange,
    int? initialValue,
  }) : this.initialValue = initialValue ?? 0;

  final Future Function(bool? isCorrect)? onChange;
  final int initialValue;

  @override
  State<JustSliderWidget> createState() => _JustSliderWidgetState();
}

class _JustSliderWidgetState extends State<JustSliderWidget> {
  late JustSliderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => JustSliderModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.csCorrectValue = random_data.randomInteger(1, 99).toDouble();
      });
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

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${_model.csCorrectValue?.toString()}に合わせて！',
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                FFLocalizations.of(context).getText(
                  'bl4yig2r' /* 0 */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 300.0,
                    child: Slider(
                      activeColor: FlutterFlowTheme.of(context).primary,
                      inactiveColor: FlutterFlowTheme.of(context).alternate,
                      min: 0.0,
                      max: 100.0,
                      value: _model.sliderValue ??=
                          widget.initialValue.toDouble(),
                      label: _model.sliderValue.toString(),
                      divisions: 100,
                      onChanged: (newValue) async {
                        newValue = double.parse(newValue.toStringAsFixed(2));
                        setState(() => _model.sliderValue = newValue);
                        await widget.onChange?.call(
                          _model.csCorrectValue == _model.sliderValue,
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/cover.png',
                          width: 20.0,
                          height: 20.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                FFLocalizations.of(context).getText(
                  'mrb9g8pt' /* 100 */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
