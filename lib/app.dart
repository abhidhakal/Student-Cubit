import 'package:flutter/material.dart';
import 'package:student_cubit/view/student_cubit_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: StudentCubitView(),);
  }
}