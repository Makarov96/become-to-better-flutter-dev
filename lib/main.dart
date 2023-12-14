import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_dependecy_inversion/feature/user/presenter/screen/screen_user.dart';
import 'package:sample_dependecy_inversion/packages/internet_conection/internet_guard_bloc/internet_guard_bloc.dart';
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
    return MaterialApp(
      title: 'Material App',
      home: BlocConsumer<InternetGuardBloc, InternetGuardState>(
        bloc: sl.get<InternetGuardBloc>(),
        listener: (context, state) {
          if (state is InternetGuardWithout) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            return;
          } else if (state is InternetGuardWith) {
            ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);
            return;
          }
        },
        builder: (context, state) {
          return const ScreenUser();
        },
      ),
    );
  }
}
