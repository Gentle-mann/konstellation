import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:konstellation/src/models/times_model.dart';
import 'package:konstellation/src/screen_size_config.dart';

import '../views/timer_field.dart';
import '../views/views.dart';

class GameDurationScreen extends StatefulWidget {
  const GameDurationScreen({super.key, required this.time, required this.add});
  final TimesModel time;
  final bool add;

  @override
  State<GameDurationScreen> createState() => _GameDurationScreenState();
}

class _GameDurationScreenState extends State<GameDurationScreen> {
  Timer? whiteTimer;
  Timer? blackTimer;
  bool isBothTimerActive = false;
  bool useSeparateTimes = false;
  bool useIncrement = false;
  String? recentTimer = '';
  late int blackCounter;
  late int whiteCounter;
  late int whiteTime;
  late int whiteInitialTime;
  late int whiteIncrement;
  late int blackTime;
  late int blackInitialTime;
  late int blackIncrement;
  late TimesModel? newTimesModel;
  late TimesModel? timesModel;
  late final audioPlayer = AudioPlayer();
  late final whiteTimeController = TextEditingController();
  late final whiteIncrementController = TextEditingController();
  late final blackTimeController = TextEditingController();
  late final blackIncrementController = TextEditingController();

  void startWhiteTime() {
    whiteTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (whiteTime == 30) {
        playLowTimeSound();
      }

      if (whiteTime > 0) {
        isBothTimerActive = true;

        setState(() {
          whiteTime--;
        });
      } else {
        setState(() {
          isBothTimerActive = false;
        });
        playTimeUpSound();

        stopWhiteTimer();
      }
    });
  }

  void startBlackTime() {
    blackTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (blackTime == 30) {
        playLowTimeSound();
      }
      if (blackTime > 0) {
        isBothTimerActive = true;

        setState(() {
          blackTime--;
        });
      } else {
        setState(() {
          isBothTimerActive = false;
        });
        playTimeUpSound();

        stopBlackTimer();
      }
    });
  }

  void stopWhiteTimer() {
    whiteTimer?.cancel();
  }

  void stopBlackTimer() {
    blackTimer?.cancel();
  }

  void resetTimer() {
    setState(() {
      whiteCounter = 0;
      blackCounter = 0;
      isBothTimerActive = true;
      whiteInitialTime = newTimesModel!.whiteDuration * 60;
      whiteTime = whiteInitialTime;

      whiteIncrement = newTimesModel!.whiteIncrement;
      blackInitialTime = newTimesModel!.blackDuration * 60;
      blackTime = blackInitialTime;
      blackIncrement = newTimesModel!.blackIncrement;
    });
  }

  String? getActiveTimer(String? activeTimer) {
    if (whiteTimer != null) {
      if (whiteTimer!.isActive) {
        activeTimer = 'white';
      }
    } else if (blackTimer != null) {
      if (blackTimer!.isActive) {
        activeTimer = 'black';
      }
    } else {
      activeTimer = '';
    }
    return activeTimer;
  }

  stopBothTimer() {
    if (whiteTimer!.isActive) {
      stopWhiteTimer();
      recentTimer = 'white';
    } else if (blackTimer!.isActive) {
      stopBlackTimer();
      recentTimer = 'black';
    }

    setState(() {
      isBothTimerActive = false;
    });
  }

  void resumeActiveTimer() {
    if (recentTimer == 'white') {
      startWhiteTime();
    } else if (recentTimer == 'black') {
      startBlackTime();
    } else {}
    setState(() {
      isBothTimerActive = true;
    });
  }

  void incrementWhiteCounter(counter) {
    setState(() {
      counter++;
      whiteCounter = counter;
    });
  }

  void incrementBlackCounter(counter) {
    setState(() {
      counter++;
    });
    blackCounter = counter;
  }

  void toggleUseIncrement(setState, bool? value) {
    setState(() {
      useIncrement = value!;
    });
  }

  void dialogSetState(setState) {
    setState(() {});
  }

  void toggleUseSeparateTime(setState, bool? value) {
    setState(() {
      useSeparateTimes = value!;
    });
  }

  void playMoveSound() {
    audioPlayer.play(AssetSource('move.mp3'));
  }

  void playLowTimeSound() {
    audioPlayer.play(AssetSource('lowtime.mp3'));
  }

  void playTimeUpSound() {
    audioPlayer.play(AssetSource('timeup.mp3'));
  }

  @override
  void initState() {
    super.initState();
    whiteInitialTime = widget.time.whiteDuration * 60;
    whiteTime = whiteInitialTime;
    whiteIncrement = widget.time.whiteIncrement;
    blackInitialTime = widget.time.blackDuration * 60;
    blackTime = blackInitialTime;
    blackIncrement = widget.time.blackIncrement;
    whiteIncrementController.text = widget.time.whiteIncrement.toString();
    whiteTimeController.text = widget.time.whiteDuration.toString();
    blackIncrementController.text = widget.time.blackIncrement.toString();
    blackTimeController.text = widget.time.blackDuration.toString();
    useIncrement = widget.time.useIncrement;
    useSeparateTimes = widget.time.useSeparateTimes;
    timesModel = TimesModel(
      whiteDuration: int.parse(whiteTimeController.text),
      whiteIncrement: int.parse(whiteIncrementController.text),
      blackDuration: int.parse(blackTimeController.text),
      blackIncrement: int.parse(blackIncrementController.text),
      useIncrement: useIncrement,
      useSeparateTimes: useSeparateTimes,
    );
    newTimesModel = timesModel;
    whiteCounter = 0;
    blackCounter = 0;
  }

  @override
  void dispose() {
    whiteIncrementController.dispose();
    whiteTimeController.dispose();
    blackIncrementController.dispose();
    blackTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWhiteThinking = whiteTimer == null ? false : true;
    final isBlackThinking = blackTimer == null ? false : true;

    final isGameOver = whiteTime == 0 || blackTime == 0;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                RotatedBox(
                  quarterTurns: 2,
                  child: buildTimerView(
                    duration: whiteTime,
                    increment: whiteIncrement,
                    color: whiteTimer != null && whiteTimer!.isActive
                        ? Colors.lightBlue
                        : Colors.grey,
                    counter: whiteCounter,
                    onTap: () {
                      playMoveSound();
                      if (!isBothTimerActive && isWhiteThinking) {
                      } else {
                        final activeTimer = getActiveTimer('');
                        if (activeTimer == null) {
                          whiteTime += whiteIncrement;
                          startBlackTime();
                          incrementBlackCounter(blackCounter);
                        } else {
                          stopWhiteTimer();
                          if (blackTimer == null) {
                            whiteTime += whiteIncrement;
                            incrementBlackCounter(blackCounter);
                            startBlackTime();
                          } else if (!blackTimer!.isActive) {
                            whiteTime += whiteIncrement;
                            incrementBlackCounter(blackCounter);
                            startBlackTime();
                          }
                        }
                      }
                    },
                    isTimeup: whiteTime == 0,
                  ),
                ),
                SizedBox(
                  height: ScreenSizeConfig.screenHeight * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (!isGameOver) {
                          final isAnyTimerActive =
                              isWhiteThinking || isBlackThinking;
                          if (!isAnyTimerActive) {
                          } else {
                            isBothTimerActive
                                ? stopBothTimer()
                                : resumeActiveTimer();
                          }
                        }
                      },
                      icon: Icon(
                          isBothTimerActive
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          size: 40,
                          color: whiteTime == 0 || blackTime == 0
                              ? Colors.grey
                              : Colors.black),
                    ),
                    IconButton(
                      onPressed: () {
                        if (!isBothTimerActive) {
                          resetTimer();
                        }
                      },
                      icon: Icon(
                        Icons.refresh,
                        size: 40,
                        color: isBothTimerActive ? Colors.grey : Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (!isBothTimerActive) {
                          newTimesModel = await openDialog();
                          setState(() {
                            //TimesModel.times.add(newTimesModel!);

                            whiteInitialTime =
                                newTimesModel!.whiteDuration * 60;
                            whiteTime = whiteInitialTime;
                            whiteIncrement = newTimesModel!.whiteIncrement;
                            blackInitialTime =
                                newTimesModel!.blackDuration * 60;
                            blackTime = blackInitialTime;
                            blackIncrement = newTimesModel!.blackIncrement;
                            whiteCounter = 0;
                            blackCounter = 0;
                            blackTimeController.text =
                                newTimesModel!.blackDuration.toString();
                          });
                        }
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 40,
                        color: isBothTimerActive ? Colors.grey : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenSizeConfig.screenHeight * 0.03),
                buildTimerView(
                  duration: blackTime,
                  increment: blackIncrement,
                  color: blackTimer != null && blackTimer!.isActive
                      ? Colors.lightBlue
                      : Colors.grey,
                  counter: blackCounter,
                  isTimeup: blackTime == 0,
                  onTap: () {
                    playMoveSound();
                    if (!isBothTimerActive && isBlackThinking) {
                    } else {
                      final activeTimer = getActiveTimer('');
                      if (activeTimer == null) {
                        blackTime += blackIncrement;
                        startWhiteTime();
                        incrementWhiteCounter(whiteCounter);
                      } else {
                        stopBlackTimer();
                        if (whiteTimer == null) {
                          blackTime += blackIncrement;
                          incrementWhiteCounter(whiteCounter);
                          startWhiteTime();
                        } else if (!whiteTimer!.isActive) {
                          blackTime += blackIncrement;
                          incrementWhiteCounter(whiteCounter);
                          startWhiteTime();
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTimerView({
    required int duration,
    required int increment,
    required VoidCallback onTap,
    required Color color,
    required int counter,
    required bool isTimeup,
  }) {
    // Color boxColor(Color newColor) {
    //   if (isTimeup) {
    //     newColor = Colors.red;
    //   } else if (duration > 30) {
    //     newColor = Colors.deepPurple;
    //   } else {
    //     newColor = color;
    //   }
    //   return newColor;
    // }

    // final boxColor = boxColor(newColor);

    final minutes = duration ~/ 60;
    final seconds = duration.remainder(60);
    return GestureDetector(
      onTap: whiteTime == 0 || blackTime == 0 ? () {} : onTap,
      child: Container(
        height: ScreenSizeConfig.screenHeight * 0.4,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isTimeup ? Colors.red : color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 20,
              child: Text(
                'Moves Counter: $counter',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Text('+ $increment',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Center(
              child: isTimeup
                  ? const Icon(
                      Icons.flag,
                      color: Colors.white,
                      size: 100,
                    )
                  : Text(
                      '$minutes:${seconds.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        fontSize: 100,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<TimesModel?> openDialog() {
    return showDialog<TimesModel>(
      context: context,
      builder: ((context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            scrollable: true,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  title: const Text('Use different times for White and Black'),
                  value: useSeparateTimes,
                  onChanged: (value) {
                    toggleUseSeparateTime(setState, value);
                  },
                ),
                CheckboxListTile(
                  title: const Text('Use Increment'),
                  value: useIncrement,
                  onChanged: (value) {
                    toggleUseIncrement(setState, value);
                  },
                ),
                if (useSeparateTimes) const MediumText(title: 'White'),
                TimerField(
                  title: 'Time (in minutes)',
                  controller: whiteTimeController,
                  autofocus: true,
                ),
                const SizedBox(height: 10),
                if (useIncrement)
                  TimerField(
                    title: 'White Increment (in seconds)',
                    controller: whiteIncrementController,
                  ),
                const SizedBox(height: 10),
                if (useSeparateTimes) const MediumText(title: 'Black'),
                if (useSeparateTimes)
                  TimerField(
                    title: 'Time (in minutes)',
                    controller: blackTimeController,
                  ),
                const SizedBox(height: 10),
                if (useIncrement)
                  TimerField(
                    title: 'Black Increment (in seconds)',
                    controller: blackIncrementController,
                  ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (whiteTimeController.text != '') {
                      timesModel = TimesModel(
                        whiteDuration: int.parse(whiteTimeController.text),
                        whiteIncrement:
                            int.tryParse(whiteIncrementController.text) ?? 0,
                        blackDuration: int.tryParse(blackTimeController.text) ??
                            int.parse(whiteTimeController.text),
                        blackIncrement:
                            int.tryParse(blackIncrementController.text) ?? 0,
                        useIncrement: useIncrement,
                        useSeparateTimes: useSeparateTimes,
                      );
                      if (!timesModel!.useSeparateTimes) {
                        timesModel!.blackDuration = timesModel!.whiteDuration;
                      }

                      Navigator.of(context).pop(timesModel);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter at the game duration.'),
                        ),
                      );
                    }
                  },
                  child: const Text('SAVE')),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        });
      }),
    );
  }
}
