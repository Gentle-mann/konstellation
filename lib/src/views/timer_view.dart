import 'package:flutter/material.dart';

import '../screen_size_config.dart';

class TimerView extends StatelessWidget {
  const TimerView({
    super.key,
    required this.duration,
    required this.increment,
    required this.onTap,
  });
  final int duration;
  final int increment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
