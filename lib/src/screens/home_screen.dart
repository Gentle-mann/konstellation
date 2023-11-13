import 'package:flutter/material.dart';
import 'package:konstellation/src/models/times_model.dart';
import 'package:konstellation/src/screen_size_config.dart';
import 'package:konstellation/src/screens/game_duration_screen.dart';
import 'package:konstellation/src/views/views.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().initialize(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final timesModel = TimesModel(
                whiteDuration: 5,
                whiteIncrement: 0,
                blackDuration: 5,
                blackIncrement: 0,
                useIncrement: false,
                useSeparateTimes: false,
              );

              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return GameDurationScreen(time: timesModel, add: false);
                }),
              );
            },
            icon: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.green,
            ),
          ),
        ],
        elevation: 0,
        title: const MediumText(
          title: 'Konstellation',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MediumText(
                title: 'Saved Games',
              ),
              SizedBox(
                height: ScreenSizeConfig.screenHeight * 0.7,
                child: ListView.builder(
                  itemCount: TimesModel.times.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return GameDurationScreen(
                              time: TimesModel.times[index],
                              add: false,
                            );
                          }),
                        );
                      },
                      child: DurationView(
                        time: TimesModel.times[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
