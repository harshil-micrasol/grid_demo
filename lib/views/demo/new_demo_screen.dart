import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'new_demo_controller.dart';

class NewDemoScreen extends StatelessWidget {
  NewDemoScreen({super.key});

  final NewDemoController con = Get.put(NewDemoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: const [],
      ),
    );
  }
}
