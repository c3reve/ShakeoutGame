import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/components/down_slider_widget.dart';
import '/components/just_slider/just_slider_widget.dart';
import '/components/quiz/quiz_widget.dart';
import '/components/step_button/step_button_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'play_widget.dart' show PlayWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
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

  QuizzesRecord? psQuiz;

  bool psIsPageLoaded = false;

  PlayError? psPlayError;

  ScoreSetStruct? psScore;
  void updatePsScoreStruct(Function(ScoreSetStruct) updateFn) =>
      updateFn(psScore ??= ScoreSetStruct());

  int psLapTime = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - Read Document] action in Play widget.
  SchedulesRecord? schedule;
  // Stores action output result for [Backend Call - Read Document] action in Play widget.
  QuizzesRecord? scheduleQuiz;
  // Stores action output result for [Firestore Query - Query a collection] action in Play widget.
  ScoresRecord? aoScore;
  // Stores action output result for [Firestore Query - Query a collection] action in Play widget.
  int? quizCount;
  // Stores action output result for [Firestore Query - Query a collection] action in Play widget.
  QuizzesRecord? randomQuiz;
  InstantTimer? vibrationTimer;
  // State field(s) for ScoreTimer widget.
  int scoreTimerMilliseconds = 0;
  String scoreTimerValue = StopWatchTimer.getDisplayTime(
    0,
    hours: false,
    minute: false,
  );
  FlutterFlowTimerController scoreTimerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countUp));

  // Model for DownSlider component.
  late DownSliderModel downSliderModel;
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
  // Stores action output result for [Backend Call - Create Document] action in StepButton widget.
  ScoresRecord? aoCreatedScore;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {
    downSliderModel = createModel(context, () => DownSliderModel());
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
    scoreTimerController.dispose();
    downSliderModel.dispose();
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
      psLapTime = scoreTimerMilliseconds;
      psScore = ScoreSetStruct(
        dropTime: scoreTimerMilliseconds / 1000,
      );
    } else if (step == GameStep.Cover) {
      // 現在のstepをHoldOnに更新
      psNowStep = GameStep.HoldOn;
      updatePsScoreStruct(
        (e) => e..coverTime = (scoreTimerMilliseconds - psLapTime) / 1000,
      );
      psLapTime = scoreTimerMilliseconds;
    } else {
      updatePsScoreStruct(
        (e) => e
          ..holdOnTime = (scoreTimerMilliseconds - psLapTime) / 1000
          ..totalTime = (60000 - scoreTimerMilliseconds) / 1000,
      );
    }
  }

  Future invalidPlay(BuildContext context) async {
    psIsPageLoaded = true;
    await Future.delayed(const Duration(milliseconds: 3000));

    context.pushNamed(
      'MainMenu',
      extra: <String, dynamic>{
        kTransitionInfoKey: TransitionInfo(
          hasTransition: true,
          transitionType: PageTransitionType.fade,
          duration: Duration(milliseconds: 0),
        ),
      },
    );
  }

  /// Additional helper methods are added here.
}
