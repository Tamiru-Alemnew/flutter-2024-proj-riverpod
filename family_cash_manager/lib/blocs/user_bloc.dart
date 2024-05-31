// user_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});

class User {
  final String userId;
  final String email;
  final String role;

  User({required this.userId, required this.email, required this.role});

}
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserAuthenticated extends UserState {
  final User user;

  UserAuthenticated({required this.user});
}

class UserError extends UserState {
  final String error;

  UserError({required this.error});
}
class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(UserInitial());

  final String baseUrl = 'http://localhost:3000/auth';

  void userLogin(String email, String password) async {
    state = UserLoading();
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        state = UserAuthenticated(
            user: User(
          userId: data['userId'],
          email: data['email'],
          role: data['role'],
        ));
      } else {
        state = UserError(error: 'Login failed');
      }
    } catch (e) {
      state = UserError(error: e.toString());
    }
  }

  void userSignUp(
      String name, String email, String password, String role) async {
    state = UserLoading();
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'role': role,
        }),
      );
      try {
        final response = await http.post(
          Uri.parse('$baseUrl/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}),
        );

        final data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          state = UserAuthenticated(
              user: User(
            userId: data["userId"],
            email: data['email'],
            role: data['role'],
          ));
        } else {
          state = UserError(error: 'Login failed');
        }
      } catch (e) {
        state = UserError(error: e.toString());
      }
    } catch (e) {
      state = UserError(error: e.toString());
    }
  }

  void logout() {
    state = UserInitial();
  }
}
