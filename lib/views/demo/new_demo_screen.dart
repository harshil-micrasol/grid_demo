import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:grid_demo/utils/utils.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import 'bottom_click_tile.dart';
import 'new_demo_controller.dart';

class NewDemoScreen extends StatefulWidget {
  const NewDemoScreen({super.key});

  @override
  State<NewDemoScreen> createState() => _NewDemoScreenState();
}

class _NewDemoScreenState extends State<NewDemoScreen> {
  final NewDemoController con = Get.put(NewDemoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => StaggeredGridView.countBuilder(
            itemCount: con.staggeredTiles.length,
            controller: con.scrollController,
            crossAxisCount: 2,
            mainAxisSpacing: defaultPadding / 2,
            crossAxisSpacing: defaultPadding / 2,
            padding: const EdgeInsets.all(defaultPadding / 2),
            staggeredTileBuilder: (index) {
              return con.staggeredTiles[index];
            },
            itemBuilder: (context, index) {
              return StaggeredCustomTile(
                onTap: () {
                  con.staggeredTiles.removeAt(index);
                },
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding).copyWith(bottom: MediaQuery.of(context).padding.bottom + defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomClickTile(
                type: "0",
                onTap: () {
                  con.addNewIItem(const StaggeredTile.count(1, 1));
                },
              ),
              BottomClickTile(
                type: "==",
                onTap: () {
                  con.addNewIItem(const StaggeredTile.count(2, 1));
                },
              ),
              BottomClickTile(
                type: "||",
                onTap: () {
                  con.addNewIItem(const StaggeredTile.count(1, 2));
                },
              ),
              BottomClickTile(
                type: "[-]",
                onTap: () {
                  con.addNewIItem(const StaggeredTile.count(2, 2));
                },
              ),
              BottomClickTile(
                type: "--",
                onTap: () {
                  con.addNewIItem(const StaggeredTile.count(1, .5));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StaggeredCustomTile extends StatelessWidget {
  final VoidCallback onTap;
  const StaggeredCustomTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.tealAccent,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: const Center(
          child: Text("data"),
        ),
      ),
    );
  }
}
