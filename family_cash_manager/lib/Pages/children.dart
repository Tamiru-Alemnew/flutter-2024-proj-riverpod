import 'package:family_cash_manager/widgets/common_sidebar.dart';
import 'package:flutter/material.dart';

class Child {
  String name;
  String role;

  Child(this.name, this.role);
}

class MangeChildren extends StatelessWidget {
  const MangeChildren({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CommonSideBar(),
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: const Text('Family Cash Manager'),
      ),
      body:  ChildrenPage(),
    );
  }
}

class ChildrenPage extends StatefulWidget {
  @override
  _ChildrenPageState createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {

  List<Child> childrenList = [
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }),
        title: Text('Children'),
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

  void _showConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Change Role"),
          content: Text(
              "Do you want to change ${childrenList[index].name}'s role?"),
          actions: [
            ElevatedButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Change"),
              onPressed: () {
                _changeRole(index);
                Navigator.of(context).pop();
                _showSnackbar();
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
