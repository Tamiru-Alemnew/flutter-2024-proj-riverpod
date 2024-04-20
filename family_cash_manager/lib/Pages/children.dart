import 'package:flutter/material.dart';

class ChildrenPage extends StatefulWidget {
  @override
  _ChildrenPageState createState() => _ChildrenPageState();
}

class _ChildrenPageState extends State<ChildrenPage> {
  List<String> childrenList = [
    'Child 1',
    'Child 2',
    'Child 3',
    'Child 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Children'),
      ),
      body: ListView.builder(
        itemCount: childrenList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(childrenList[index]),
            subtitle: Text('Role: ${_getRole(index)}'),
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

  String _getRole(int index) {
    if (childrenList[index].startsWith('Child')) {
      return 'Child';
    } else {
      return 'Parent ${index + 1}';
    }
  }

  void _showConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Change Role"),
          content: Text(
              "Do you want to change ${childrenList[index]}'s role to parent?"),
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
    setState(() {
      childrenList[index] = 'Parent ${index + 1}';
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
