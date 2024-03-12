import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'develop_schedule_model.dart';
export 'develop_schedule_model.dart';

class DevelopScheduleWidget extends StatefulWidget {
  const DevelopScheduleWidget({super.key});

  @override
  State<DevelopScheduleWidget> createState() => _DevelopScheduleWidgetState();
}

class _DevelopScheduleWidgetState extends State<DevelopScheduleWidget> {
  late DevelopScheduleModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DevelopScheduleModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'fl5hzmxz' /* Page Title */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Figtree',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              StreamBuilder<List<SchedulesRecord>>(
                stream: querySchedulesRecord(
                  queryBuilder: (schedulesRecord) =>
                      schedulesRecord.orderBy('start_time', descending: true),
                  limit: 10,
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    );
                  }
                  List<SchedulesRecord> listViewSchedulesRecordList =
                      snapshot.data!;
                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: listViewSchedulesRecordList.length,
                    separatorBuilder: (_, __) => SizedBox(height: 2.0),
                    itemBuilder: (context, listViewIndex) {
                      final listViewSchedulesRecord =
                          listViewSchedulesRecordList[listViewIndex];
                      return StreamBuilder<List<ScoresRecord>>(
                        stream: queryScoresRecord(
                          queryBuilder: (scoresRecord) => scoresRecord
                              .where(
                                'userRef',
                                isEqualTo: currentUserReference,
                              )
                              .where(
                                'scheduleRef',
                                isEqualTo: listViewSchedulesRecord.reference,
                              ),
                          singleRecord: true,
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          List<ScoresRecord> listTileScoresRecordList =
                              snapshot.data!;
                          final listTileScoresRecord =
                              listTileScoresRecordList.isNotEmpty
                                  ? listTileScoresRecordList.first
                                  : null;
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                'Play',
                                queryParameters: {
                                  'mode': serializeParam(
                                    GameMode.Real,
                                    ParamType.Enum,
                                  ),
                                  'scheduleRef': serializeParam(
                                    listViewSchedulesRecord.reference,
                                    ParamType.DocumentReference,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: ListTile(
                              title: Text(
                                '${dateTimeFormat(
                                  'M/d H:mm',
                                  listViewSchedulesRecord.startTime,
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                )}〜${dateTimeFormat(
                                  'Hm',
                                  listViewSchedulesRecord.endTime,
                                  locale:
                                      FFLocalizations.of(context).languageCode,
                                )}',
                                style: FlutterFlowTheme.of(context).titleLarge,
                              ),
                              subtitle: Text(
                                listTileScoresRecord?.reference != null
                                    ? 'スコア：${listTileScoresRecord?.time?.toString()}'
                                    : '未挑戦',
                                style: FlutterFlowTheme.of(context).labelMedium,
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 20.0,
                              ),
                              tileColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              dense: false,
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ].divide(SizedBox(height: 20.0)),
          ),
        ),
      ),
    );
  }
}
