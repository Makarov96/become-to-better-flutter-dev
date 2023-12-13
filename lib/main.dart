import 'package:flutter/material.dart';
import 'package:sample_dependecy_inversion/feature/user/presenter/screen/screen_user.dart';
import 'package:sample_dependecy_inversion/sl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: ScreenUser(),
    );
  }
}
