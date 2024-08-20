import 'package:flutter_test/flutter_test.dart';


import '../lib/database.dart';
import '../lib/source_enum.dart';
import '../lib/user.dart';

void main() {
  late Database database;
  late User user;

  setUp(() {
    database = Database();
    user = User(firstName: "Ikay", lastName: "Codes");
  });
  group('Test database crud functions', () {

    test('Create new user when addNewUser method is called', () {
      database.addNewUser(user);

      expect(database.activeUsers.contains(user), true);
    });

    test('Move user to archived when moveToArchived method is called', () {
      database.moveToArchived(user);

      expect(database.activeUsers.contains(user), false);
      expect(database.archivedUsers.contains(user), true);
    });

    test('Delete user from active when deleteUser is called on an active user', () {
      database.deleteUser(user: user, source: Source.active);
      expect(database.activeUsers.contains(user), false);
    });
  });
}