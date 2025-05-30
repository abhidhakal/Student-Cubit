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
        appBar: AppBar(title: const Text("Student Cubit")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(labelText: "Age"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: "Address"),
              ),
              const SizedBox(height: 10),

              BlocBuilder<StudentCubit, StudentState>(
                builder: (context, state) {
                  final cubit = context.read<StudentCubit>();
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          final student = StudentModel(
                            name: nameController.text.trim(),
                            age: int.tryParse(ageController.text.trim()) ?? 0,
                            address: addressController.text.trim(),
                          );

                          cubit.addStudent(student);

                          nameController.clear();
                          ageController.clear();
                          addressController.clear();
                        },
                        child: const Text("Submit"),
                      ),
                      const SizedBox(height: 20),
                      if (state.isLoading)
                        const CircularProgressIndicator(),
                      if (!state.isLoading && state.lstStudents.isEmpty)
                        const Text("No students added yet"),
                      if (!state.isLoading && state.lstStudents.isNotEmpty)
                        SizedBox(
                          height: 300, // Give it height for scroll
                          child: ListView.builder(
                            itemCount: state.lstStudents.length,
                            itemBuilder: (context, index) {
                              final student = state.lstStudents[index];
                              return ListTile(
                                title: Text(student.name),
                                subtitle:
                                    Text("${student.age} | ${student.address}"),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    cubit.deleteStudent(student);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
