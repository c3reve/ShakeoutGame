import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '../backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../index.dart';
import '../../main.dart';

final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    if (mounted) {
      setState(() => _loading = true);
    }
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        context.pushNamed(
          initialPageName,
          pathParameters: parameterData.pathParameters,
          extra: parameterData.extra,
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? isWeb
          ? Container()
          : Container(
              color: FlutterFlowTheme.of(context).tertiary,
              child: Image.asset(
                'assets/images/icon.png',
                fit: BoxFit.contain,
              ),
            )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'MainMenu': ParameterData.none(),
  'Settings': ParameterData.none(),
  'LeaderBoard': ParameterData.none(),
  'Play': (data) async => ParameterData(
        allParams: {
          'scheduleRef': getParameter<DocumentReference>(data, 'scheduleRef'),
        },
      ),
  'Tutorial': ParameterData.none(),
  'Success': (data) async => ParameterData(
        allParams: {
          'time': getParameter<int>(data, 'time'),
          'quizeDoc': await getDocumentParameter<QuizzesRecord>(
              data, 'quizeDoc', QuizzesRecord.fromSnapshot),
          'scoreDoc': await getDocumentParameter<ScoresRecord>(
              data, 'scoreDoc', ScoresRecord.fromSnapshot),
          'isSuccess': getParameter<bool>(data, 'isSuccess'),
        },
      ),
  'TopPage': ParameterData.none(),
  'develop_quiz': ParameterData.none(),
  'develop_menu': ParameterData.none(),
  'develop_sound': ParameterData.none(),
  'Ranking': ParameterData.none(),
  'develop_slider': ParameterData.none(),
  'develop_schedule': ParameterData.none(),
  'rankingDetail': (data) async => ParameterData(
        allParams: {
          'prScheduleDoc': await getDocumentParameter<SchedulesRecord>(
              data, 'prScheduleDoc', SchedulesRecord.fromSnapshot),
        },
      ),
  'MyItems': ParameterData.none(),
  'ItemDetail': (data) async => ParameterData(
        allParams: {
          'itemRef': getParameter<DocumentReference>(data, 'itemRef'),
          'userItemRef': getParameter<DocumentReference>(data, 'userItemRef'),
        },
      ),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
