import 'package:family_cash_manager/blocs/family_members_bloc.dart';
import 'package:family_cash_manager/blocs/user_bloc.dart';
import 'package:family_cash_manager/widgets/presentation/common_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManageChildren extends ConsumerWidget {
  const ManageChildren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    if (userState is UserAuthenticated) {
      if (userState.user.role != 'parent') {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('You must be a parent to edit categories')),
          );
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pop(context);
        });
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
    } else {
      return Center(child: CircularProgressIndicator());
    }
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
                              final userState =
                                  context.read(userProvider).state;
                              if (userState is UserAuthenticated) {
                                context
                                    .read(familyMembersProvider.notifier)
                                    .updateRole(
                                      id: childrenList[index].userId,
                                      role: childrenList[index].role == "parent"
                                          ? "children"
                                          : "parent",
                                    );
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Role changed successfully'),
                                  ),
                                );
                              }
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
