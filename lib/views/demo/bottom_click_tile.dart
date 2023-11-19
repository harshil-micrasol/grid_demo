import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';
import 'new_demo_controller.dart';

class BottomClickTile extends StatelessWidget {
  final VoidCallback onTap;
  final String type;

  BottomClickTile({
    super.key,
    required this.onTap,
    required this.type,
  });

  final NewDemoController con = Get.find<NewDemoController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
        con.scrollController.animateTo(con.scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.fastEaseInToSlowEaseOut);
      },
      borderRadius: BorderRadius.circular(defaultRadius),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
          border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)),
        ),
        child: Center(
          child: Text(
            type,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
