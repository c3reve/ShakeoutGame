import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'empty_text_model.dart';
export 'empty_text_model.dart';

class EmptyTextWidget extends StatefulWidget {
  const EmptyTextWidget({
    super.key,
    String? text,
  }) : this.text = text ?? 'データがありません';

  final String text;

  @override
  State<EmptyTextWidget> createState() => _EmptyTextWidgetState();
}

class _EmptyTextWidgetState extends State<EmptyTextWidget> {
  late EmptyTextModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyTextModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Text(
        widget.text,
        style: FlutterFlowTheme.of(context).bodyMedium,
      ),
    );
  }
}
