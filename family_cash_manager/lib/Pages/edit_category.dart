import 'package:flutter/material.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({Key? key});

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  List<String> categories = ['Food', 'Transport'];
  TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 78, 75, 82),
        title: const Text(
          "Family Cash Manager",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
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
                      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
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
                      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 36, 120, 109))),
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
    );
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }
}

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
