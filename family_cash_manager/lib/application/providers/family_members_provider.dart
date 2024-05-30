import 'package:equatable/equatable.dart';
import 'package:family_cash_manager/domain/model/user.dart';
// import 'package:family_cash_manager/application/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final familyMembersProvider =
    StateNotifierProvider<FamilyMembersNotifier, FamilyMembersState>(
        (ref) => FamilyMembersNotifier());

class FamilyMember extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateRole extends FamilyMember {
  final int id;
  final String role;

  UpdateRole({required this.id, required this.role});

  @override
  List<Object> get props => [id, role];
}

class FamilyMembersState extends Equatable {
  @override
  List<Object> get props => [];
}

class FamilyMembersInitial extends FamilyMembersState {}

class FamilyMembersLoading extends FamilyMembersState {}

class FamilyMembersLoaded extends FamilyMembersState {
  final List<dynamic> familyMembers;

  FamilyMembersLoaded({required this.familyMembers});

  @override
  List<Object> get props => [familyMembers];
}

class FamilyMembersError extends FamilyMembersState {
  final String error;

  FamilyMembersError({required this.error});

  @override
  List<Object> get props => [error];
}


class FamilyMembersNotifier extends StateNotifier<FamilyMembersState> {
  final String baseUrl = 'http://localhost:3000/auth';
  FamilyMembersNotifier() : super(FamilyMembersInitial()) {
    getAllFamilyMembers();
  }

  Future<void> getAllFamilyMembers() async {
    state = FamilyMembersLoading();
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/getallUsers'),
        headers: {'Content-Type': 'application/json'},
      );

      final data = jsonDecode(response.body);

      if (data.isNotEmpty) {
        List<User> users = [];
        for (var user in data) {
          users.add(User(
            userId: user['id'],
            email: user['email'],
            role: user['role'],
          ));
        }
        state = FamilyMembersLoaded(familyMembers: users);
      } else {
        state = FamilyMembersError(error: 'Failed to get users');
      }
    } catch (e) {
      state = FamilyMembersError(error: e.toString());
    }
  }

  Future<void> updateRole(int id, String role) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/updateRole'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': id,
          'role': role,
        }),
      );
      getAllFamilyMembers();
    } catch (e) {
      state = FamilyMembersError(error: e.toString());
    }
  }
}
