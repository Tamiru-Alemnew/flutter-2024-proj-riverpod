
import 'package:family_cash_manager/blocs/category_bloc.dart';
import 'package:family_cash_manager/screens/presentations/login_page.dart';
import 'package:family_cash_manager/widgets/presentation/common_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditCategoryPage extends ConsumerWidget {
  const EditCategoryPage({Key? key}) : super(key: key);

  Future<String> getUserRole(BuildContext context, WidgetRef ref) async {
    final userState = ref.read(userProvider);
    if (userState is UserAuthenticated) {
      return userState.user.role;
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<String>(
      future: getUserRole(context, ref),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data != 'parent') {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('You must be a parent to edit categories')),
            );
          });
          Navigator.pop(context);
          return Container();
        } else {
          return Scaffold(
            drawer: const CommonSideBar(),
            appBar: AppBar(
              title: const Text('Family Cash Manager'),
            ),
            body: Consumer(
              builder: (context, WidgetRef ref, child) {
                final categoryState = ref.watch(categoryProvider);
                return categoryState.map(
                  loading: (_) => Center(child: CircularProgressIndicator()),
                  loaded: (state) {
                    return Column(
                      children: [
                        const EditExpense(),
                      ],
                    );
                  },
                  error: (state) => Center(child: Text(state.message)),
                );
              },
            ),
          );
        }
      },
    );
  }
}

class EditExpense extends ConsumerStatefulWidget {
  const EditExpense({Key? key}) : super(key: key);

  @override
  _EditExpenseState createState() => _EditExpenseState();
}

class _EditExpenseState extends ConsumerState<EditExpense> {
  TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(categoryProvider.notifier).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final categoryState = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Category',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add categories to help your family members track their expenses",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              categoryState.map(
                loading: (_) => Center(child: CircularProgressIndicator()),
                loaded: (state) {
                  return Column(
                    children: state.categories.map((category) {
                      return CategoryItem(
                        category: category,
                        onEdit: (newName) {
                          ref.read(categoryProvider.notifier).updateCategory(
                              id: category['id'] ?? '', newName: newName);
                        },
                        onDelete: () {
                          ref
                              .read(categoryProvider.notifier)
                              .deleteCategory(id: category['id'] ?? '');
                        },
                      );
                    }).toList(),
                  );
                },
                error: (state) => Center(child: Text(state.message)),
                initial: (_) => Center(child: Text("No categories available")),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Add new category",
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 36, 120, 109)),
                    ),
                    onPressed: () {
                      String newCategory = _categoryController.text.trim();
                      if (newCategory.isNotEmpty) {
                        ref.read(categoryProvider.notifier).addCategory(
                              name: newCategory,
                            );
                        _categoryController.clear();
                      }
                    },
                    child: Text(
                      "Add Category",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 36, 120, 109)),
                    ),
                    onPressed: () {
                      print("Done");
                    },
                    child: Text("Done", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }
}

class CategoryItem extends ConsumerStatefulWidget {
  final Map category;
  final Function(String)? onEdit;
  final VoidCallback? onDelete;

  const CategoryItem({
    Key? key,
    required this.category,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends ConsumerState<CategoryItem> {
  bool _isEditing = false;
  late TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _editingController =
        TextEditingController(text: widget.category[widget.category['id']]);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _isEditing
                  ? TextField(
                      controller: _editingController,
                      autofocus: true,
                      onEditingComplete: () {
                        _submitEdit();
                      },
                      onSubmitted: (_) {
                        _submitEdit();
                      },
                    )
                  : Text(
                      widget.category[widget.category['id']],
                      style: const TextStyle(fontSize: 16),
                    ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = true;
                    });
                  },
                  icon: Icon(Icons.edit),
                  color: Theme.of(context).primaryColor,
                ),
                IconButton(
                  onPressed: () {
                    if (widget.onDelete != null) {
                      widget.onDelete!();
                    }
                  },
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _submitEdit() {
    setState(() {
      _isEditing = false;
    });
    if (widget.onEdit != null) {
      widget.onEdit!(_editingController.text.trim());
    }
    ref.read(categoryProvider.notifier).updateCategory(
        id: widget.category["id"], newName: _editingController.text.trim());
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }
}
