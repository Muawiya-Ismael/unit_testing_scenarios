import 'package:flutter/material.dart';


import 'source_enum.dart';
import 'user.dart';

class Database extends ChangeNotifier {
  List<User> activeUsers = [];
  List<User> archivedUsers = [];

  void addNewUser(User user) {
    activeUsers.add(user);
    notifyListeners();
  }

  void moveToArchived(User user) {
    archivedUsers.add(user);
    activeUsers.remove(user);
    notifyListeners();
  }

  void moveToActive(User user) {
    activeUsers.add(user);
    archivedUsers.remove(user);
    notifyListeners();
  }

  bool deleteUser({required User user, required Source source}) {
    switch (source) {
      case Source.active:
        activeUsers.remove(user);
        notifyListeners();
        return true;
      case Source.archived:
        archivedUsers.remove(user);
        notifyListeners();
        return true;
    }

  }
}