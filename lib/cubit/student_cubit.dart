import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_cubit/model/student_model.dart';
import 'package:student_cubit/state/student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  StudentCubit() : super(StudentState.initial());

  void addStudent(StudentModel student) {
    emit(state.copyWith(isLoading: true));
    
    Future.delayed(Duration(seconds: 1), () {
      emit(state.copyWith(
        lstStudents: [...state.lstStudents, student], isLoading: false
      ));
    });
  }

  void deleteStudent(StudentModel student) {
    emit(state.copyWith(isLoading: true));
    
    Future.delayed(Duration(seconds: 1), () {
      emit(state.copyWith(
        lstStudents: state.lstStudents..remove(student), isLoading: false
      ));
    });
  }

  void reset() {
    emit(StudentState.initial());
  }
}
