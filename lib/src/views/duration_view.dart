import 'package:flutter/material.dart';
import 'package:konstellation/src/models/times_model.dart';

class DurationView extends StatelessWidget {
  const DurationView({super.key, required this.time});
  final TimesModel time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Text(
                  '${time.whiteDuration} + ${time.whiteIncrement}, ${time.blackDuration} + ${time.blackIncrement}',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.play_arrow_rounded),
                      color: Colors.green,
                    ),
                    const Text('Play'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit_rounded,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const Text('Edit'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete_rounded,
                        color: Colors.red,
                      ),
                    ),
                    const Text('Delete'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
