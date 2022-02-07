import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final String name;
  final String? address;

  const Person({required this.name, this.address});

  @override
  List<Object?> get props => [name, address];
}