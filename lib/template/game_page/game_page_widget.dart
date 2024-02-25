import '/components/rank_points_table_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'game_page_model.dart';
export 'game_page_model.dart';

class GamePageWidget extends StatefulWidget {
  const GamePageWidget({
    super.key,
    required this.correctOption,
    required this.currentLevel,
  });

  final String? correctOption;
  final int? currentLevel;

  @override
  State<GamePageWidget> createState() => _GamePageWidgetState();
}

class _GamePageWidgetState extends State<GamePageWidget>
    with TickerProviderStateMixin {
  late GamePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'buttonOnActionTriggerAnimation': AnimationInfo(
      trigger: AnimationTrigger.onActionTrigger,
      applyInitialState: true,
      effects: [
        ScaleEffect(
          curve: Curves.bounceOut,
          delay: 0.ms,
          duration: 860.ms,
          begin: Offset(1.0, 1.0),
          end: Offset(1.05, 1.1),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GamePageModel());

    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

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
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  wrapWithModel(
                    model: _model.rankPointsTableModel,
                    updateCallback: () => setState(() {}),
                    child: RankPointsTableWidget(),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 48.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Level ${widget.currentLevel?.toString()}',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Figtree',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 24.0, 0.0, 24.0),
                          child: LinearPercentIndicator(
                            percent: 0.5,
                            width: MediaQuery.sizeOf(context).width * 0.85,
                            lineHeight: 16.0,
                            animation: true,
                            animateFromLastPercent: true,
                            progressColor: FlutterFlowTheme.of(context).primary,
                            backgroundColor:
                                FlutterFlowTheme.of(context).accent1,
                            barRadius: Radius.circular(8.0),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'tbp6m8js' /* Question 1/20 */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
                    child: Text(
                      'This is a long text. But in this page, you should choose ${widget.correctOption}',
                      style: FlutterFlowTheme.of(context).displaySmall,
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      final optionButtons = _model.options.toList();
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: optionButtons.length,
                        itemBuilder: (context, optionButtonsIndex) {
                          final optionButtonsItem =
                              optionButtons[optionButtonsIndex];
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 4.0, 0.0, 8.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                if (animationsMap[
                                        'buttonOnActionTriggerAnimation'] !=
                                    null) {
                                  animationsMap[
                                          'buttonOnActionTriggerAnimation']!
                                      .controller
                                      .forward(from: 0.0);
                                }
                                HapticFeedback.selectionClick();
                                if (optionButtonsItem == widget.correctOption) {
                                  context.pushNamed(
                                    'ConfettiWinnerPage',
                                    queryParameters: {
                                      'currentLevel': serializeParam(
                                        widget.currentLevel,
                                        ParamType.int,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 1000),
                                      ),
                                    },
                                  );
                                }
                              },
                              text: optionButtonsItem,
                              options: FFButtonOptions(
                                height: 60.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Figtree',
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                elevation: 3.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ).animateOnActionTrigger(
                              animationsMap['buttonOnActionTriggerAnimation']!,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
