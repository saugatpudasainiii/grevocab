import 'package:bookstolook/core/viewmodels/login_viewmodel.dart';
import 'package:bookstolook/ui/views/homepage.dart';
import 'package:bookstolook/ui/views/navigation.dart';
import 'package:bookstolook/ui/views/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/viewmodels/signUp_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignUpModel()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ),
      ),
    );
  }
}
