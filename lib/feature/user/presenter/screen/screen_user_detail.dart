import 'package:flutter/material.dart';
import 'package:sample_dependecy_inversion/feature/services/param_through_screen/param_through_screen.dart';
import 'package:sample_dependecy_inversion/sl.dart';

class ScreenUserDetail extends StatelessWidget {
  const ScreenUserDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sl.get<ParamsThroughScreen>().userName),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
