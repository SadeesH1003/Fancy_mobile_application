import 'package:fancy/model/user.dart';
import 'package:fancy/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbols.dart';

class AdminProvider extends ChangeNotifier {
  List<User> _users = [];
  bool isLoading = false;
  final FirebaseService _firebaseService = FirebaseService();

  List<User> get users => _users;

  Future<void> getAllUsers() async {
    try {
      isLoading = true;
      notifyListeners();

      final userData = await _firebaseService.getDocuments("Users");

      _users = userData.docs.map((doc) => User.fromMap(doc)).toList();

      print('Fetched Products:');
      for (var user in _users) {
        print(user.username);
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      print("Error fetching products: $e");
      throw e;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
