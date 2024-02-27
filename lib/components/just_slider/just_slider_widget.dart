import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
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
    this.correct,
  }) : this.initialValue = initialValue ?? 0;

  final Future Function(bool? isCorrect)? onChange;
  final int initialValue;
  final double? correct;

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
        _model.csCorrectValue = widget.correct != null
            ? widget.correct
            : random_data.randomInteger(1, 99).toDouble();
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
            FFLocalizations.of(context).getText(
              'rrfjl5w8' /* スライドで頭をカバー！ */,
            ),
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    'bl4yig2r' /* 0 */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ),
              Container(
                width: 300.0,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                      child: Container(
                        width: 300.0,
                        child: Slider(
                          activeColor: FlutterFlowTheme.of(context).primary,
                          inactiveColor: FlutterFlowTheme.of(context).primary,
                          min: 0.0,
                          max: 100.0,
                          value: _model.sliderValue ??=
                              widget.initialValue.toDouble(),
                          label: _model.sliderValue.toString(),
                          divisions: 100,
                          onChanged: (newValue) async {
                            newValue =
                                double.parse(newValue.toStringAsFixed(2));
                            setState(() => _model.sliderValue = newValue);
                            await widget.onChange?.call(
                              _model.csCorrectValue == _model.sliderValue,
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(),
                        child: Align(
                          alignment: AlignmentDirectional(
                              valueOrDefault<double>(
                                functions.normalizationAlignment(
                                    _model.csCorrectValue!),
                                0.0,
                              ),
                              0.0),
                          child: Container(
                            width: 64.0,
                            height: 64.0,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, -1.0),
                                  child: Icon(
                                    Icons.person_2,
                                    color: _model.csCorrectValue ==
                                            _model.sliderValue
                                        ? FlutterFlowTheme.of(context).tertiary
                                        : FlutterFlowTheme.of(context)
                                            .secondaryText,
                                    size: 64.0,
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, -1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 14.0, 0.0, 0.0),
                                    child: Text(
                                      ((_model.csCorrectValue!).toInt())
                                          .toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Figtree',
                                            color: FlutterFlowTheme.of(context)
                                                .info,
                                            fontSize: 12.0,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (false)
                      Align(
                        alignment: AlignmentDirectional(
                            valueOrDefault<double>(
                              functions.normalizationAlignment(
                                  _model.csCorrectValue!),
                              0.0,
                            ),
                            0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/DALLE_2024-02-26_11.04.58_-_Create_a_minimalist_monochrome_illustration_of_a_person_crouching,_focusing_on_clean_lines_and_geometric_simplicity._The_person_is_abstracted_into_a_s.webp',
                            width: 50.0,
                            height: 50.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                child: Text(
                  FFLocalizations.of(context).getText(
                    'mrb9g8pt' /* 100 */,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
