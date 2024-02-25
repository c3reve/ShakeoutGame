import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/components/just_slider_widget.dart';
import '/components/quiz_widget.dart';
import '/components/step_button_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'play_widget.dart' show PlayWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class PlayModel extends FlutterFlowModel<PlayWidget> {
  ///  Local state fields for this page.

  GameStep? psNowStep = GameStep.Drop;

  bool psCanProceed = false;

  List<GameStep> psDoneSteps = [];
  void addToPsDoneSteps(GameStep item) => psDoneSteps.add(item);
  void removeFromPsDoneSteps(GameStep item) => psDoneSteps.remove(item);
  void removeAtIndexFromPsDoneSteps(int index) => psDoneSteps.removeAt(index);
  void insertAtIndexInPsDoneSteps(int index, GameStep item) =>
      psDoneSteps.insert(index, item);
  void updatePsDoneStepsAtIndex(int index, Function(GameStep) updateFn) =>
      psDoneSteps[index] = updateFn(psDoneSteps[index]);

  int? psSliderValue = 0;

  bool psIsUp = true;

  QuizzesRecord? psQuiz;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  AudioPlayer? soundPlayer;
  // Stores action output result for [Backend Call - Read Document] action in Play widget.
  SchedulesRecord? schedule;
  // Stores action output result for [Backend Call - Read Document] action in Play widget.
  QuizzesRecord? scheduleQuiz;
  // Stores action output result for [Firestore Query - Query a collection] action in Play widget.
  int? quizCount;
  // Stores action output result for [Backend Call - Read Document] action in Play widget.
  QuizzesRecord? randomQuiz;
  InstantTimer? vibrationTimer;
  // State field(s) for Timer widget.
  int timerMilliseconds = 0;
  String timerValue = StopWatchTimer.getDisplayTime(
    0,
    hours: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countUp));

  // Model for JustSlider component.
  late JustSliderModel justSliderModel;
  // Model for Quiz component.
  late QuizModel quizModel;
  // Model for StepButton component.
  late StepButtonModel stepButtonModel1;
  // Model for StepButton component.
  late StepButtonModel stepButtonModel2;
  // Model for StepButton component.
  late StepButtonModel stepButtonModel3;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    justSliderModel = createModel(context, () => JustSliderModel());
    quizModel = createModel(context, () => QuizModel());
    stepButtonModel1 = createModel(context, () => StepButtonModel());
    stepButtonModel2 = createModel(context, () => StepButtonModel());
    stepButtonModel3 = createModel(context, () => StepButtonModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    vibrationTimer?.cancel();
    timerController.dispose();
    justSliderModel.dispose();
    quizModel.dispose();
    stepButtonModel1.dispose();
    stepButtonModel2.dispose();
    stepButtonModel3.dispose();
  }

  /// Action blocks are added here.

  Future doneStep(
    BuildContext context, {
    GameStep? step,
  }) async {
    addToPsDoneSteps(step!);
    psCanProceed = false;
    if (step == GameStep.Drop) {
      // 現在のstepをDropに更新
      psNowStep = GameStep.Cover;
    } else if (step == GameStep.Cover) {
      // 現在のstepをHoldOnに更新
      psNowStep = GameStep.HoldOn;
      psCanProceed = true;
    }
  }

  /// Additional helper methods are added here.
}
