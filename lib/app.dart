import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_cubit/cubit/student_cubit.dart';
import 'package:student_cubit/view/student_cubit_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: BlocProvider(create: (context) => StudentCubit(), child: StudentCubitView(),), debugShowCheckedModeBanner: false,);
  }
}