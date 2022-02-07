import '../model/user.dart';

abstract class UserRepository {
  Future<User> getUser();
  void saveDataUser(User user);
}