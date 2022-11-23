/*
  Created by: Claizel Coubeili Cepe
  Date: 27 October 2022
  Description: Sample todo app with networking
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week7_networking_discussion/models/todo_model.dart';
import 'package:week7_networking_discussion/providers/todo_provider.dart';
import 'package:week7_networking_discussion/screens/modal_todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({super.key});

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  @override
  Widget build(BuildContext context) {
    // access the list of todos in the provider
    Stream<QuerySnapshot> friendsStream = context.watch<FriendListProvider>().friends;

    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: StreamBuilder(
        stream: friendsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text("No Todos Found"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: ((context, index) {
              Friend friend = Friend.fromJson(
                  snapshot.data?.docs[index].data() as Map<String, dynamic>);
              return Dismissible(
                key: Key(friend.userName.toString()),
                onDismissed: (direction) {
                  context.read<FriendListProvider>().changeSelectedFriend(friend);
                  context.read<FriendListProvider>().deleteFriend();

                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${friend.displayName} dismissed')));
                },
                background: Container(
                  color: Colors.red,
                  child: const Icon(Icons.delete),
                ),
                child: ListTile(
                  title: Text(friend.displayName),
                  // leading: Checkbox(
                  //   value: friend.friends,
                  //   onChanged: (bool? value) {
                  //     context
                  //         .read<FriendListProvider>()
                  //         .toggleStatus(index, value!);
                  //   },
                  // ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) => TodoModal(
                          //     type: 'Edit',
                          //     todoIndex: index,
                          //   ),
                          // );
                        },
                        icon: const Icon(Icons.create_outlined),
                      ),
                      IconButton(
                        onPressed: () {
                          context
                              .read<FriendListProvider>()
                              .changeSelectedFriend(friend);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => FriendModal(
                              type: 'Delete',
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete_outlined),
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => FriendModal(
              type: 'Add',
              // todoIndex:
              //     -1, // Flag to identify that this particular modal is for add
            ),
          );
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
