import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_cubit/cubit/student_cubit.dart';
import 'package:student_cubit/model/student_model.dart';
import 'package:student_cubit/state/student_state.dart';


class StudentCubitView extends StatelessWidget {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();

  StudentCubitView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StudentCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text("Student Cubit")),
        body: BlocBuilder<StudentCubit, StudentState>(
          builder: (context, state) {
            var cubit = context.read<StudentCubit>();
             return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
                  TextFormField(controller: ageController, decoration: InputDecoration(labelText: "Age")),
                  TextFormField(controller: addressController, decoration: InputDecoration(labelText: "Address")),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      final student = StudentModel(
                        name: nameController.text,
                        age: ageController.text,
                        address: addressController.text,
                      );
                      cubit.addStudent(student);

                      nameController.clear();
                      ageController.clear();
                      addressController.clear();
                    },
                    child: Text("Submit"),
                  ),
                  SizedBox(height: 20),
                  if (state is StudentInitial) Text("No students added yet"),
                    if (state is StudentLoading) CircularProgressIndicator(),
                  if (state is StudentLoaded)
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.students.length,
                        itemBuilder: (_, index) {
                          final student = state.students[index];
                          return ListTile(
                            title: Text(student.name),
                            subtitle: Text("${student.age} | ${student.address}"),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => cubit.removeStudent(index),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}