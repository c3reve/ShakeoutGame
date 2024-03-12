import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_text_widget.dart';
import '/components/l_b_rank_points_current_user_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'ranking_detail_model.dart';
export 'ranking_detail_model.dart';

class RankingDetailWidget extends StatefulWidget {
  const RankingDetailWidget({
    super.key,
    required this.prScheduleDoc,
  });

  final SchedulesRecord? prScheduleDoc;

  @override
  State<RankingDetailWidget> createState() => _RankingDetailWidgetState();
}

class _RankingDetailWidgetState extends State<RankingDetailWidget> {
  late RankingDetailModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RankingDetailModel());

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
          backgroundColor: FlutterFlowTheme.of(context).tertiary,
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
              '6ioijjin' /* ランキング詳細 */,
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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 0.0, 0.0),
                    child: Text(
                      dateTimeFormat(
                        'M/d H:mm',
                        widget.prScheduleDoc!.startTime!,
                        locale: FFLocalizations.of(context).languageCode,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Figtree',
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                PagedListView<DocumentSnapshot<Object?>?,
                    ScoresRecord>.separated(
                  pagingController: _model.setListViewController(
                    ScoresRecord.collection
                        .where(
                          'scheduleRef',
                          isEqualTo: widget.prScheduleDoc?.reference,
                        )
                        .orderBy('time', descending: true),
                  ),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  reverse: false,
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (_, __) => SizedBox(height: 8.0),
                  builderDelegate: PagedChildBuilderDelegate<ScoresRecord>(
                    // Customize what your widget looks like when it's loading the first page.
                    firstPageProgressIndicatorBuilder: (_) => Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    ),
                    // Customize what your widget looks like when it's loading another page.
                    newPageProgressIndicatorBuilder: (_) => Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (_) => EmptyTextWidget(
                      text: '該当者なし',
                    ),
                    itemBuilder: (context, _, listViewIndex) {
                      final listViewScoresRecord = _model
                          .listViewPagingController!.itemList![listViewIndex];
                      return FutureBuilder<UsersRecord>(
                        future: UsersRecord.getDocumentOnce(
                            listViewScoresRecord.userRef!),
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
                          final containerUsersRecord = snapshot.data!;
                          return Container(
                            height: 60.0,
                            decoration: BoxDecoration(),
                            child: LBRankPointsCurrentUserWidget(
                              key: Key(
                                  'Keyqje_${listViewIndex}_of_${_model.listViewPagingController!.itemList!.length}'),
                              name: containerUsersRecord.displayName,
                              score: listViewScoresRecord.time,
                              rank: functions.returnAdd(listViewIndex),
                              prImagePath: containerUsersRecord.photoUrl,
                              isCurrentUser: containerUsersRecord.reference ==
                                  currentUserReference,
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
      ),
    );
  }
}
