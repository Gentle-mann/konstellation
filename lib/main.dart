import 'package:flutter/material.dart';
import 'package:konstellation/src/providers/timer_provider.dart';
import 'package:provider/provider.dart';

import 'src/screens/screens.dart';

void main() {
  runApp(const Konstellation());
}

class Konstellation extends StatelessWidget {
  const Konstellation({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TimerProvider(),
      child: MaterialApp(
        title: 'Konstellation',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
