import 'package:flutter/material.dart';

import 'screens/home_shell.dart';
import 'theme.dart';

void main() {
  runApp(const EmDtsApp());
}

/// EMD-TS — Remote Patient Screening (Demo).
///
/// This is a demonstration application. The medical AI is mocked and performs
/// no real inference; every clinical measurement is simulated and labeled as
/// such on screen.
class EmDtsApp extends StatelessWidget {
  const EmDtsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EMD-TS — Remote Patient Screening (Demo)',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const HomeShell(),
    );
  }
}
