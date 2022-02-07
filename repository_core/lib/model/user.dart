import '../model/person.dart';

class User extends Person {
  const User({
    required String name,
    required this.id,
    required this.username,
  }) : super(name: name);

  final String id;
  final String username;

  @override
  List<Object?> get props => super.props..addAll([id, username]);
}
