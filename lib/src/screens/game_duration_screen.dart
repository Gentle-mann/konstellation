import 'package:flutter/material.dart';
import 'package:konstellation/src/models/times_model.dart';
import 'package:konstellation/src/screen_size_config.dart';

import '../views/views.dart';

class GameDurationScreen extends StatefulWidget {
  const GameDurationScreen({super.key, required this.time});
  final TimesModel time;

  @override
  State<GameDurationScreen> createState() => _GameDurationScreenState();
}

class _GameDurationScreenState extends State<GameDurationScreen> {
  late final whiteTimeController = TextEditingController();
  late final whiteIncrementController = TextEditingController();
  late final blackTimeController = TextEditingController();
  late final blackIncrementController = TextEditingController();
  @override
  void initState() {
    super.initState();
    whiteIncrementController.text = widget.time.whiteIncrement.toString();
    whiteTimeController.text = widget.time.whiteDuration.toString();
    blackIncrementController.text = widget.time.blackIncrement.toString();
    blackTimeController.text = widget.time.blackDuration.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RotatedBox(
                quarterTurns: 2,
                child: TimerView(
                  duration: widget.time.whiteDuration,
                  increment: widget.time.whiteIncrement,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.play_arrow_rounded,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.refresh,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return SizedBox(
                              height: ScreenSizeConfig.screenHeight * 0.1,
                              child: AlertDialog(
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CheckboxListTile(
                                      title: Text(
                                          'Use different times for White and Black'),
                                      value: true,
                                      onChanged: (value) {},
                                    ),
                                    CheckboxListTile(
                                      title: Text('Use Increment'),
                                      value: true,
                                      onChanged: (value) {},
                                    ),
                                    MediumText(title: 'White'),
                                    TimerField(
                                      title: 'Time (in minutes)',
                                      controller: whiteTimeController,
                                    ),
                                    TimerField(
                                      title: 'Increment',
                                      controller: whiteIncrementController,
                                    ),
                                    const SizedBox(height: 10),
                                    MediumText(title: 'Black'),
                                    TimerField(
                                      title: 'Time (in minutes)',
                                      controller: blackTimeController,
                                    ),
                                    TimerField(
                                      title: 'Increment',
                                      controller: blackIncrementController,
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('SAVE')),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'CANCEL',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }));
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 40,
                    ),
                  ),
                ],
              ),
              TimerView(
                duration: widget.time.blackDuration,
                increment: widget.time.blackIncrement,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerField extends StatelessWidget {
  const TimerField({
    super.key,
    required this.title,
    required this.controller,
  });
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(label: Text(title)),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({
    super.key,
    required this.duration,
    required this.increment,
  });
  final int duration;
  final int increment;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSizeConfig.screenHeight * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          const Positioned(
            top: 10,
            right: 20,
            child: Text(
              'Moves Counter: 0',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              '$duration:00',
              style: const TextStyle(
                fontSize: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
