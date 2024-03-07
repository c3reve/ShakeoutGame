import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'decimal_time_model.dart';
export 'decimal_time_model.dart';

class DecimalTimeWidget extends StatefulWidget {
  const DecimalTimeWidget({
    super.key,
    required this.time,
    double? fontSize,
    Color? color,
  })  : this.fontSize = fontSize ?? 14.0,
        this.color = color ?? const Color(0xFF57636C);

  final double? time;
  final double fontSize;
  final Color color;

  @override
  State<DecimalTimeWidget> createState() => _DecimalTimeWidgetState();
}

class _DecimalTimeWidgetState extends State<DecimalTimeWidget> {
  late DecimalTimeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DecimalTimeModel());

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
      decoration: BoxDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            formatNumber(
              widget.time,
              formatType: FormatType.custom,
              format: '#.',
              locale: '',
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Figtree',
                  color: widget.color,
                  fontSize: widget.fontSize,
                ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
                0.0,
                0.0,
                0.0,
                valueOrDefault<double>(
                  ((widget.fontSize * 0.05).toInt()).toDouble(),
                  0.0,
                )),
            child: Text(
              valueOrDefault<String>(
                (String var1) {
                  return var1.split('.')[1];
                }(formatNumber(
                  widget.time,
                  formatType: FormatType.custom,
                  format: '#.000',
                  locale: '',
                )),
                '0',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Figtree',
                    color: widget.color,
                    fontSize: widget.fontSize * 0.8,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
