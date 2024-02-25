import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'top_page_model.dart';
export 'top_page_model.dart';

class TopPageWidget extends StatefulWidget {
  const TopPageWidget({super.key});

  @override
  State<TopPageWidget> createState() => _TopPageWidgetState();
}

class _TopPageWidgetState extends State<TopPageWidget> {
  late TopPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TopPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).tertiary,
        body: SafeArea(
          top: true,
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              GoRouter.of(context).prepareAuthEvent();
              final user = await authManager.signInAnonymously(context);
              if (user == null) {
                return;
              }

              context.goNamedAuth('MainMenu', context.mounted);
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  FFLocalizations.of(context).getText(
                    '87dm7fwb' /* Tap to start */,
                  ),
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).titleMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
