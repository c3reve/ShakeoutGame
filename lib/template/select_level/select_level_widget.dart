import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'select_level_model.dart';
export 'select_level_model.dart';

class SelectLevelWidget extends StatefulWidget {
  const SelectLevelWidget({super.key});

  @override
  State<SelectLevelWidget> createState() => _SelectLevelWidgetState();
}

class _SelectLevelWidgetState extends State<SelectLevelWidget> {
  late SelectLevelModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectLevelModel());

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
        backgroundColor: FlutterFlowTheme.of(context).primary,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: true,
          leading: FlutterFlowIconButton(
            borderColor: FlutterFlowTheme.of(context).primary,
            borderRadius: 20.0,
            borderWidth: 1.0,
            buttonSize: 40.0,
            fillColor: FlutterFlowTheme.of(context).accent1,
            icon: Icon(
              Icons.arrow_back_outlined,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () async {
              if (Navigator.of(context).canPop()) {
                context.pop();
              }
              context.pushNamed('MainMenu');
            },
          ),
          title: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              FFLocalizations.of(context).getText(
                'bdnr0kdh' /* Select Level */,
              ),
              style: FlutterFlowTheme.of(context).titleLarge,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Builder(
                  builder: (context) {
                    final levels = FFAppState().levelsList.toList();
                    return ListView.builder(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        16.0,
                        0,
                        32.0,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: levels.length,
                      itemBuilder: (context, levelsIndex) {
                        final levelsItem = levels[levelsIndex];
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 8.0, 16.0, 4.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              if (!levelsItem.isLevelLocked) {
                                context.pushNamed(
                                  'GamePage',
                                  queryParameters: {
                                    'correctOption': serializeParam(
                                      () {
                                        if (levelsIndex == 0) {
                                          return 'Apples';
                                        } else if (levelsIndex == 1) {
                                          return 'Oranges';
                                        } else {
                                          return 'Grapes';
                                        }
                                      }(),
                                      ParamType.String,
                                    ),
                                    'currentLevel': serializeParam(
                                      levelsItem.levelNumber,
                                      ParamType.int,
                                    ),
                                  }.withoutNulls,
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType:
                                          PageTransitionType.bottomToTop,
                                      duration: Duration(milliseconds: 400),
                                    ),
                                  },
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 6.0, 12.0, 0.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/burger.png',
                                              width: 50.0,
                                              height: 50.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                levelsItem.levelName,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .headlineSmall
                                                    .override(
                                                      fontFamily: 'Figtree',
                                                      color: levelsIndex <=
                                                              FFAppState()
                                                                  .lastAchievedLevel
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                    ),
                                              ),
                                              Text(
                                                levelsItem.levelDesc,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium,
                                              ),
                                            ].divide(SizedBox(height: 4.0)),
                                          ),
                                        ),
                                        if (levelsItem.isLevelLocked)
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 8.0, 0.0),
                                            child: Icon(
                                              Icons.lock,
                                              color: Color(0xFFCFC8FB),
                                              size: 24.0,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 0.0, 2.0),
                                        child: Text(
                                          '${!levelsItem.isLevelLocked ? ((levelsItem.completionPerc * 100).toInt()).toString() : '0'}%',
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium,
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 1.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 4.0, 8.0, 12.0),
                                          child: LinearPercentIndicator(
                                            percent: !levelsItem.isLevelLocked
                                                ? levelsItem.completionPerc
                                                : 0.0,
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.7,
                                            lineHeight: 12.0,
                                            animation: true,
                                            animateFromLastPercent: true,
                                            progressColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .accent4,
                                            barRadius: Radius.circular(4.0),
                                            padding: EdgeInsets.zero,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ].divide(SizedBox(height: 8.0)),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
