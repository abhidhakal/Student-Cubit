import 'package:equatable/equatable.dart';

class StudentModel extends Equatable {
  final String name;
  final int age;
  final String address;

  const StudentModel({
    required this.name,
    required this.age,
    required this.address,
  });

  @override
  List<Object?> get props => [name, age, address];
}
