import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/Pages/updatedialog.dart';
import 'dart:convert';
import '../di/di.dart';
import 'dialog.dart';

class TodoList extends ConsumerStatefulWidget {
  const TodoList({super.key});
  @override
  ConsumerState createState() => _TodoListState();
}

class _TodoListState extends ConsumerState<TodoList> {
  @override
  Widget build(BuildContext contexts) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO"),
        actions: [
          Consumer(builder: (context, ref, child) {
            return IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Are You Sure ti Clear all Data'),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              ref.read(TodoProvider).clearall();
                              ref.read(TodoProvider).getdata();
                              Navigator.pop(context);
                            },
                            child: Text("Delete All"))
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.bookmark_remove));
          })
        ],
      ),
      body: Consumer(builder: (context, ref, child) {
        var data = ref.watch(TodoProvider).sharedstorage;
        return ListView.separated(
            // reverse: true,
            itemCount: data.length,
            // itemExtent: 60,
            padding: const EdgeInsets.all(20),
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            itemBuilder: (context, index) {
              var sd = json.decode(data[index]);
              return ListTile(
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: Text("${sd["Task"]}"),
                subtitle: Text("${sd["Dropdown"]} ${sd["Time"]} "),
                leading: const Icon(Icons.add_task_rounded),
                onLongPress: () async {
                  ref
                      .read(DropdownProvider)
                      .updatedialogchanger(sd["Dropdown"]);
                  Map data = await showDialog(
                      context: context,
                      builder: (context) => UpdateDialogTodo(data: sd));
                  if (data['Changed'] == true) {
                    ref.read(TodoProvider).updatedata(data, index);
                    ref.read(TodoProvider).getdata();
                  }
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Are You Sure to Delete"),
                          actions: [
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancels")),
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        ref
                                            .read(TodoProvider)
                                            .deleteData(index);
                                        ref.read(TodoProvider).getdata();

                                        Navigator.pop(context);
                                      },
                                      child: const Text("Delete")),
                                )
                              ],
                            )
                          ],
                        );
                      },
                    )
                  },
                ),
                // tileColor: ,
              );
            });
      }),
      floatingActionButton: Consumer(
        builder: (context, ref, child) => FloatingActionButton(
          onPressed: () async {
            Map todotask = await showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const DialogTodo());
            if (todotask['Changed'] == true) {
              ref.read(TodoProvider).setdata(todotask);
              ref.read(TodoProvider).getdata();
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
