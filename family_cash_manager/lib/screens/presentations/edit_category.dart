import 'package:family_cash_manager/widgets/presentation/common_sidebar.dart';
import 'package:flutter/material.dart';

/// The EditCatagoryPage class represents the page for editing a category in the Family Cash Manager app.
/// This class extends StatelessWidget and defines the UI layout using Scaffold. It includes a drawer for
/// navigation and an app bar with the app title. The body of the page is populated with the EditExpense widget,
/// which contains the form and controls for editing the category details.
class EditCatagoryPage extends StatelessWidget {
  const EditCatagoryPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CommonSideBar(),
      appBar: AppBar(
        title: const Text('Family Cash Manager'),
      ),
      body: const EditExpense(),
    );
  }
}

/// The EditExpense class represents the form for editing an expense category in the Family Cash Manager app.
/// It extends StatefulWidget, indicating that the UI of this form can change dynamically based on user interactions
/// and state updates. The class overrides the createState() method to create an instance of _EditExpenseState,
/// which manages the state of the EditExpense form.
class EditExpense extends StatefulWidget {
  const EditExpense({Key? key});

  @override
  _EditExpenseState createState() => _EditExpenseState();
}

/// The _EditExpenseState class represents the state of the EditExpense form in the Family Cash Manager app.
/// It manages the dynamic data and user interactions for editing expense categories. This class extends the
/// State class and overrides the build() method to define the UI layout and functionality of the EditExpense form.
/// It includes a list of categories, a text field for adding new categories, and buttons for adding categories and
/// completing the editing process. The state is updated using the setState() method, reflecting changes made by the user.
class _EditExpenseState extends State<EditExpense> {
  List<String> categories = ['Food', 'Transport'];
  TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
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
                Column(
                  children: categories.map((category) {
                    return CategoryItem(
                      category: category,
                      onEdit: () {
                        // Handle edit category
                        print('Editing $category');
                      },
                      onDelete: () {
                        setState(() {
                          categories.remove(category);
                        });
                      },
                    );
                  }).toList(),
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 36, 120, 109))),
                      onPressed: () {
                        setState(() {
                          String newCategory = _categoryController.text.trim();
                          if (newCategory.isNotEmpty &&
                              !categories.contains(newCategory)) {
                            categories.add(newCategory);
                            _categoryController.clear();
                          }
                        });
                      },
                      child: Text(
                        "Add Category",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 36, 120, 109))),
                      onPressed: () {
                        print("Done");
                      },
                      child:
                          Text("Done", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }
}

/// The CategoryItem class represents an item widget for displaying and interacting with an expense category.
/// It extends StatefulWidget, indicating that the UI of this item can change dynamically based on user interactions
/// and state updates. The class overrides the createState() method to create an instance of _CategoryItemState,
/// which manages the state of the CategoryItem.
///
/// The CategoryItem widget takes in the category name, and optional callbacks for editing and deleting the category.
/// It provides a visual representation of the category and allows the user to perform actions on it.

class CategoryItem extends StatefulWidget {
  final String category;
  final VoidCallback? onEdit;
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

/// The _CategoryItemState class represents the state of a CategoryItem widget in the Family Cash Manager app.
/// It manages the dynamic data and user interactions for displaying and interacting with an expense category item.
/// This class extends the State class and overrides the build() method to define the UI layout and functionality
/// of the CategoryItem. It includes a card widget that displays the category name and provides options for editing
/// and deleting the category. The state is updated using the setState() method, reflecting changes made by the user.

class _CategoryItemState extends State<CategoryItem> {
  bool _isEditing = false;
  late TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: widget.category);
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
                        setState(() {
                          _isEditing = false;
                        });
                      },
                      onSubmitted: (_) {
                        setState(() {
                          _isEditing = false;
                        });
                      },
                    )
                  : Text(
                      widget.category,
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
                    if (widget.onEdit != null) {
                      widget.onEdit!();
                    }
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

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }
}
