import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'step_button_model.dart';
export 'step_button_model.dart';

class StepButtonWidget extends StatefulWidget {
  const StepButtonWidget({
    super.key,
    required this.step,
    bool? isEnable,
    bool? isDone,
    required this.onDone,
  })  : this.isEnable = isEnable ?? false,
        this.isDone = isDone ?? false;

  final GameStep? step;
  final bool isEnable;
  final bool isDone;
  final Future Function()? onDone;

  @override
  State<StepButtonWidget> createState() => _StepButtonWidgetState();
}

class _StepButtonWidgetState extends State<StepButtonWidget> {
  late StepButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StepButtonModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: 100.0,
      height: 100.0,
      child: Stack(
        children: [
          Opacity(
            opacity: widget.isEnable && !widget.isDone ? 1.0 : 0.5,
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Builder(
                builder: (context) {
                  if (widget.step == GameStep.Drop) {
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(),
                      child: Builder(
                        builder: (context) {
                          if (widget.isEnable && !widget.isDone) {
                            return Container(
                              width: 100.0,
                              height: 100.0,
                              child: CarouselSlider(
                                items: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/drop.png',
                                      width: 100.0,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/drop.png',
                                      width: 100.0,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                                carouselController:
                                    _model.dropCarouselController ??=
                                        CarouselController(),
                                options: CarouselOptions(
                                  initialPage: 1,
                                  viewportFraction: 1.0,
                                  disableCenter: true,
                                  enlargeCenterPage: false,
                                  enlargeFactor: 0.0,
                                  enableInfiniteScroll: false,
                                  scrollDirection: Axis.vertical,
                                  autoPlay: false,
                                  onPageChanged: (index, _) async {
                                    _model.dropCarouselCurrentIndex = index;
                                    if (_model.dropCarouselCurrentIndex == 0) {
                                      HapticFeedback.selectionClick();
                                      _model.soundPlayer1 ??= AudioPlayer();
                                      if (_model.soundPlayer1!.playing) {
                                        await _model.soundPlayer1!.stop();
                                      }
                                      _model.soundPlayer1!.setVolume(1.0);
                                      _model.soundPlayer1!
                                          .setAsset('assets/audios/drop.mp3')
                                          .then((_) =>
                                              _model.soundPlayer1!.play());

                                      await widget.onDone?.call();
                                    }
                                  },
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              width: 100.0,
                              height: 100.0,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/drop.png',
                                      width: 100.0,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    );
                  } else if (widget.step == GameStep.Cover) {
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(),
                      child: Builder(
                        builder: (context) {
                          if (widget.isEnable && !widget.isDone) {
                            return Container(
                              width: 100.0,
                              height: 100.0,
                              child: CarouselSlider(
                                items: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/cover.png',
                                      width: 100.0,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/cover.png',
                                      width: 100.0,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                                carouselController:
                                    _model.coverCarouselController ??=
                                        CarouselController(),
                                options: CarouselOptions(
                                  initialPage: 1,
                                  viewportFraction: 1.0,
                                  disableCenter: true,
                                  enlargeCenterPage: false,
                                  enlargeFactor: 0.0,
                                  enableInfiniteScroll: false,
                                  scrollDirection: Axis.horizontal,
                                  autoPlay: false,
                                  onPageChanged: (index, _) async {
                                    _model.coverCarouselCurrentIndex = index;
                                    if (_model.coverCarouselCurrentIndex == 0) {
                                      HapticFeedback.selectionClick();
                                      _model.soundPlayer2 ??= AudioPlayer();
                                      if (_model.soundPlayer2!.playing) {
                                        await _model.soundPlayer2!.stop();
                                      }
                                      _model.soundPlayer2!.setVolume(1.0);
                                      _model.soundPlayer2!
                                          .setAsset('assets/audios/cover.mp3')
                                          .then((_) =>
                                              _model.soundPlayer2!.play());

                                      await widget.onDone?.call();
                                    }
                                  },
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              width: 100.0,
                              height: 100.0,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/cover.png',
                                      width: 100.0,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    );
                  } else if (widget.step == GameStep.HoldOn) {
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onLongPress: () async {
                          HapticFeedback.selectionClick();
                          await widget.onDone?.call();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/hold_on.png',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(),
                    );
                  }
                },
              ),
            ),
          ),
          if (widget.isDone)
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  'tthvyh5m' /* クリア！ */,
                ),
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily: 'Figtree',
                      color: FlutterFlowTheme.of(context).secondary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
