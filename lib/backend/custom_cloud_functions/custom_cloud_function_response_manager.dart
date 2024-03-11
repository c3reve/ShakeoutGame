import '/backend/schema/structs/index.dart';

class OnScheduleNotificationCloudFunctionCallResponse {
  OnScheduleNotificationCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
}

class OnScheduleDoneCloudFunctionCallResponse {
  OnScheduleDoneCloudFunctionCallResponse({
    this.errorCode,
    this.succeeded,
    this.jsonBody,
  });
  String? errorCode;
  bool? succeeded;
  dynamic jsonBody;
}
