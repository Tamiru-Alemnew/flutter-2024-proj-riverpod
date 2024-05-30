import 'package:family_cash_manager/application/providers/family_members_provider.dart';
import 'package:family_cash_manager/application/providers/user_provider.dart';
import 'package:family_cash_manager/presentation/widgets/custom/common_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ManageChildren extends ConsumerWidget {
  
  const ManageChildren({Key? key}) : super(key: key);
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
          body: ChildrenPage(),
       );
      }
    },
  );
}
}

class ChildrenPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final familyMembersState = ref.watch(familyMembersProvider);
    if (familyMembersState is FamilyMembersLoaded) {
      final childrenList = familyMembersState.familyMembers;
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
              key: ValueKey(childrenList[index].userId),
              title: Text(childrenList[index].email),
              subtitle: Text(childrenList[index].role),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Change Role"),
                        content: Text(
                            "Do you want to change ${childrenList[index].email}'s role?"),
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
                              final userState = ref.watch(userProvider);
                              if (userState is UserAuthenticated) {
                                ref
                                    .read(familyMembersProvider.notifier)
                                    .updateRole(
                                      childrenList[index].userId,
                                      childrenList[index].role == "parent"
                                          ? "children"
                                          : "parent",
                                    );
                              }
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Role changed successfully'),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
