import 'package:family_cash_manager/application/providers/category_provider.dart';
import 'package:family_cash_manager/application/providers/user_provider.dart';
import 'package:family_cash_manager/presentation/widgets/custom/common_sidebar.dart';
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
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.data?.trim() != 'parent') {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('You must be a parent to edit categories')),
            );
            Navigator.pop(context);
          });
          return const SizedBox();
        } else {
          return Scaffold(
            drawer: const CommonSideBar(),
            appBar: AppBar(
              title: const Text('Family Cash Manager'),
            ),
            body:  const EditExpense(),
          );
        }
      },
    );
  }
}

class EditExpense extends ConsumerWidget {
  const EditExpense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _categoryController = TextEditingController();

    final categoryState = ref.watch(categoryProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add categories to help your family members track their expenses",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            categoryState is CategoryLoading
                ? const Center(child: CircularProgressIndicator())
                : categoryState is CategoryLoaded
                    ? Column(
                        children: categoryState.categories.map((category) {
                          return CategoryItem(
                            category: category,
                            onEdit: (newName) {
                              ref
                                  .read(categoryProvider.notifier)
                                  .updateCategory(
                                      category['id'] ?? '', newName);
                            },
                            onDelete: () {
                              ref
                                  .read(categoryProvider.notifier)
                                  .deleteCategory(category['id'] ?? '');
                            },
                          );
                        }).toList(),
                      )
                    : categoryState is CategoryError
                        ? Center(child: Text(categoryState.message))
                        : const Center(child: Text("No categories available")),
            const SizedBox(height: 20),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
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
                            newCategory,
                          );
                      _categoryController.clear();
                    }
                  },
                  child: const Text(
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
                  child:
                      const Text("Done", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
    _editingController = TextEditingController(text: widget.category[widget.category['id']]);
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
                      onEditingComplete: _submitEdit,
                      onSubmitted: (_) => _submitEdit(),
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
                  icon: const Icon(Icons.edit),
                  color: Theme.of(context).primaryColor,
                ),
                IconButton(
                  onPressed: () {
                    if (widget.onDelete != null) {
                      widget.onDelete!();
                    }
                  },
                  icon: const Icon(Icons.delete),
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
    ref
        .read(categoryProvider.notifier)
        .updateCategory(widget.category["id"], _editingController.text.trim());
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }
}
