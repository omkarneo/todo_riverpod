import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../di/di.dart';

class DialogTodo extends StatefulWidget {
  const DialogTodo({super.key});

  @override
  State<DialogTodo> createState() => _DialogTodoState();
}

class _DialogTodoState extends State<DialogTodo> {
  Map data = {"Task": "", "Time": "", "Dropdown": "AT HOME", "Changed": false};

  final formKey = GlobalKey<FormState>();
  TextEditingController task = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List option = ["AT OFFICE", "AT HOME", "AWAY"];
    return Form(
      key: formKey,
      child: AlertDialog(
        title: const Text("Add Task"),
        content: const Text("Add the Task for the List"),
        actions: [
          TextFormField(
            decoration: const InputDecoration(hintText: "Task"),
            controller: task,
            onChanged: (value) {
              data['Changed'] = true;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return ("Please Enter a Task");
              }
              return (null);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text("Location :- "),
              Consumer(
                builder: (context, ref, child) => DropdownButton(
                  value: ref.watch(DropdownProvider).createdialog,
                  // value: Text(data['Dropdown']),
                  items: option
                      .map<DropdownMenuItem<String>>(
                          (e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    ref.read(DropdownProvider).createdialogchanger(value);
                    data["Changed"] = true;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Consumer(
            builder: (context, ref, child) => ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    data['Dropdown'] = ref.watch(DropdownProvider).createdialog;
                    data['Task'] = task.text;
                    data['Time'] = DateTime.now().toIso8601String();
                    //     "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}";
                    Navigator.pop(context, data);
                  }
                },
                child: const Text("Add Task")),
          ),
        ],
      ),
    );
  }
}
