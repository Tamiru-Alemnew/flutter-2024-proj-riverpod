import 'package:family_cash_manager/widgets/presentation/common_sidebar.dart';
import 'package:flutter/material.dart';

class Child {
  String name;
  String role;

  Child(this.name, this.role);
}

/// This class represents the screen for managing children in the Family Cash Manager app.
/// It extends StatelessWidget to provide a static user interface that doesn't change based on data.

class MangeChildren extends StatelessWidget {
  const MangeChildren({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CommonSideBar(),
      appBar: AppBar(
        title: const Text('Family Cash Manager'),
      ),
      body: ChildrenPage(),
    );
  }
}

/// This class represents the page for managing children in the Family Cash Manager app.
/// It extends StatefulWidget to provide a dynamic user interface that can change based on data and user interactions.
class ChildrenPage extends StatefulWidget {
  @override
  _ChildrenPageState createState() => _ChildrenPageState();
}

/// This class represents the state of the ChildrenPage widget in the Family Cash Manager app.
/// It manages the list of children and their information.
class _ChildrenPageState extends State<ChildrenPage> {
  List<Child> childrenList = [
    // List of Child objects with their names and roles
    Child('jon doe', 'Child'),
    Child('jane doe', 'Child'),
    Child('Abebe kebede', 'Child'),
    Child('Mulugeta kebede', 'Child'),
    Child('jordan haile', 'Child'),
    Child('selam haile', 'Child'),
    Child('betty haile', 'Child'),
    Child('michael haile', 'Child'),
    Child('daniel haile', 'Child'),
    Child('sara haile', 'Child'),
    Child('ursula haile', 'Child'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text(
          'Manage Children',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: ListView.builder(
        itemCount: childrenList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(childrenList[index].name),
            subtitle: Text('Role: ${childrenList[index].role}'),
            trailing: IconButton(
              icon: Icon(Icons.swap_horiz),
              onPressed: () {
                _showConfirmationDialog(index);
              },
            ),
          );
        },
      ),
    );
  }

  /// Shows a confirmation dialog when the user wants to change a child's role.
  /// The dialog prompts the user to confirm the role change for the specified child.
  /// If the user confirms, the role is changed, and a snackbar is shown to indicate the success.
  void _showConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Change Role"),
          content: Text(
              "Do you want to change ${childrenList[index].name}'s role?"), // Confirmation message with the child's name
          actions: [
            ElevatedButton(
              child: Text("Cancel"), // Cancel button
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Change"),
              onPressed: () {
                _changeRole(
                    index); // Call _changeRole method to update the child's role
                Navigator.of(context).pop();
                _showSnackbar(); // Show a snackbar to indicate the success of the role change
              },
            ),
          ],
        );
      },
    );
  }

  void _changeRole(int index) {
    if (childrenList[index].role == 'Parent ') {
      setState(() {
        childrenList[index].role = 'Child';
      });
      return;
    }
    setState(() {
      childrenList[index].role = 'Parent ';
    });
  }

  void _showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Role changed successfully'),
      ),
    );
  }
}
