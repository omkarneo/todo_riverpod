import 'dart:async';
import 'package:flutter/material.dart';
import 'Pages/todopage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'di/di.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: "Todo App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        routes: {
          "/": (context) => const FirstPage(),
          "/todo": (context) => const TodoList(),
        },
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    var duration = const Duration(seconds: 1);
    Timer(
      duration,
      () => Navigator.pushReplacementNamed(context, '/todo'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(
      builder: (context, ref, child) {
        ref.watch(TodoProvider).getdata();
        return const Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.flutter_dash, size: 150),
                Text(
                  "Todo App",
                  style: TextStyle(fontSize: 50),
                ),
              ]),
        );
      },
    ));
  }
}
