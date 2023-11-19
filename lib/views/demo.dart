// import 'package:flutter/material.dart';
// import 'package:grid_demo/res/color_print.dart';
// import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
// import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

// class StaggeredLayout extends StatefulWidget {
//   const StaggeredLayout({super.key});

//   @override
//   State<StaggeredLayout> createState() => _StaggeredLayoutState();
// }

// class _StaggeredLayoutState extends State<StaggeredLayout> {
//   // A list of all the occupied positions in the layout.
//   List<Offset> occupiedPositions = [];
//   // A list of all the empty positions in the layout.
//   List<Offset> emptyPositions = [];
//   // The number of columns in the layout.
//   int numColumns = 2;
//   // The number of rows in the layout.
//   int numRows = 4;
//   // The children of the layout.
//   List<Widget> children = [
//     Container(
//       key: const Key("0.0/0.0"),
//       color: Colors.red,
//       height: 100.0,
//       width: 100.0,
//     ),
//     Container(
//       key: const Key("1.0/1.0"),
//       color: Colors.green,
//       height: 100.0,
//       width: 100.0,
//     ),
//     Container(
//       key: const Key("2.0/2.0"),
//       color: Colors.blue,
//       height: 100.0,
//       width: 100.0,
//     ),
//   ];

//   Offset convertStringOffset(String stringOff) {
//     List<String> childPositionList = stringOff.split("/");
//     Offset offset = Offset(double.tryParse(childPositionList[0].replaceAll("[<'", "")) ?? 0.0, double.tryParse(childPositionList[1].replaceAll("'>]", "")) ?? 0.0);

//     // printOkStatus(offset);
//     return offset;
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Find all the occupied positions in the layout.

//     for (Widget child in children) {
//       printOkStatus(child.key.runtimeType);

//       Offset? position;

//       if (child.key != null) {
//         position = convertStringOffset(child.key.toString());
//       }
//       if (position != null) {
//         occupiedPositions.add(position);
//       } else {
//         printOkStatus("position null");
//       }
//     }
//     // Find all the empty positions in the layout.
//     for (int x = 0; x < numColumns; x++) {
//       for (int y = 0; y < numRows; y++) {
//         Offset position = Offset(x.toDouble(), y.toDouble());
//         if (!occupiedPositions.contains(position)) {
//           emptyPositions.add(position);
//         }
//       }
//     }
//   }

//   // Finds an empty position in the layout.
//   Offset findEmptyPosition() {
//     if (emptyPositions.isEmpty) {
//       return const Offset(0.0, 0.0);
//     } else {
//       return emptyPositions.first;
//     }
//   }

//   /*  // Handles the drop event.
//   void onAccept(Offset position) {
//     // Remove the child from the old position.
//     children.removeWhere((child) => convertStringOffset(child.key.toString()) == position);
//     // Add the child to the new position.
//     printOkStatus(Key(position.toString()));
//     children.add(
//       Container(
//         key: Key(position.toString()),
//         color: Colors.yellow,
//         height: 100.0,
//         width: 100.0,
//       ),
//     );
//     // Update the occupied positions list.
//     occupiedPositions.add(position);
//     // Update the empty positions list.
//     emptyPositions.removeWhere((position) => occupiedPositions.contains(position));
//     // Set the state to rebuild the layout.
//     setState(() {});
//   } */

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           StaggeredGridView.countBuilder(
//             itemCount: children.length,
//             crossAxisCount: numColumns,
//             mainAxisSpacing: 10.0,
//             crossAxisSpacing: 10.0,
//             itemBuilder: (context, index) {
//               return LongPressDraggable(
//                 feedback: children[index],
//                 data: children[index].key,
//                 child: DragTarget(
//                   onAccept: (position) {
//                     Widget  widget = con.itemsList.removeAt(oldIndex);
//                     con.itemsList.insert(index, widget);

//                     printOkStatus(convertStringOffset(position.toString()));

//                     // Remove the child from the old position.
// //  index = children.indexWhere((child) => convertStringOffset(child.key.toString()) == convertStringOffset(position.toString()));

//                     Widget tempWidget = children[index];

//                     children.removeAt(index);

//                     // Add the child to the new position.
//                     children.insert(index, tempWidget);

//                     // Update the occupied positions list.
//                     // occupiedPositions.add(position);
//                     // Update the empty positions list.
//                     emptyPositions.removeWhere((position) => occupiedPositions.contains(position));
//                     // Set the state to rebuild the layout.
//                     setState(() {});
//                   },
//                   builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) {
//                     return children[index];
//                   },
//                 ),
//                 onDraggableCanceled: (velocity, offset) {},
//               );
//             },
//             staggeredTileBuilder: (index) {
//               return const StaggeredTile.extent(1, 100.0);
//             },
//           ),
//           // DropTarget(
//           //   onAccept: onAccept,
//           // ),
//         ],
//       ),
//     );
//   }
// }
