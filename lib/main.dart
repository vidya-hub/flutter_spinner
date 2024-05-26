import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spinner_wheel/spin_provider.dart';
import 'package:spinner_wheel/wheel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SpinProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        home: const SpinWheel(),
      ),
    );
  }
}
