import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final categoryProvider = StateNotifierProvider<CategoryNotifier, CategoryState>(
    (ref) => CategoryNotifier());

class CategoryNotifier extends StateNotifier<CategoryState> {
  final String baseUrl = 'http://localhost:3000/category';

  CategoryNotifier() : super(CategoryInitial()) {
    getCategories();
  }
  

  Future<void> getCategories() async {
    state = CategoryLoading();
    try {
      final response = await http.get(Uri.parse(baseUrl));
      final data = jsonDecode(response.body);
     
      if (data.isNotEmpty) {
        List<Map> categories = data.map<Map>((category) {
          return {
            'id': category['id'].toString(),
            category['id'].toString(): category['name']
          };
        }).toList();
        
        state = CategoryLoaded(categories: categories);
      } else {
        state = CategoryLoaded(categories: []);
      }
    } catch (e) {
      state = CategoryError(message: e.toString());
    }
  }

  Future<void> addCategory(String name) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'name': name}),
      );
      if (response.statusCode == 201) {
        getCategories();
      } else {
        state = CategoryError(message: 'Failed to add category');
      }
    } catch (e) {
      state = CategoryError(message: 'Failed to add category');
    }
  }

  Future<void> deleteCategory(String id) async {
    state = CategoryLoading();
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        getCategories();
      } else {
        state = CategoryError(message: 'Failed to delete category');
      }
    } catch (e) {
      state = CategoryError(message: 'Failed to delete category');
    }
  }

  Future<void> updateCategory(String id, String newName) async {
    state = CategoryLoading();
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'name': newName}),
      );
      if (response.statusCode == 200) {
        getCategories();
      } else {
        state = CategoryError(message: 'Failed to update category');
      }
    } catch (e) {
      state = CategoryError(message: 'Failed to update category');
    }
  }
}

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Map> categories;
  CategoryLoaded({required this.categories});
}

class CategoryError extends CategoryState {
  final String message;
  CategoryError({required this.message});
}
