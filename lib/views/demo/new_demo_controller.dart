import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../res/color_print.dart';

class NewDemoController extends GetxController {
  ScrollController scrollController = ScrollController();

  RxList<StaggeredTile> staggeredTiles = <StaggeredTile>[
    const StaggeredTile.count(1, 1),
    const StaggeredTile.count(1, 2),
  ].obs;

  StaggeredTile findEmptyPositionForNewItem(StaggeredTile newItem) {
    int x = 0; // Start from the first column
    int y = 0; // Start from the top row

    while (true) {
      // Check if the current position is empty
      bool positionIsOccupied = staggeredTiles.any((tile) {
        // printOkStatus(tile.crossAxisCellCount + x <= 4 && tile.mainAxisCellCount! + y <= 4);
        return tile.crossAxisCellCount + x <= 4 && tile.mainAxisCellCount! + y <= 4;
      });
      printOkStatus(newItem.crossAxisCellCount);
      printOkStatus(newItem.mainAxisCellCount);

      if (!positionIsOccupied) {
        return StaggeredTile.count(newItem.crossAxisCellCount, newItem.mainAxisCellCount);
      }

      // Move to the next position in the grid
      x++;
      if (x >= 4) {
        x = 0;
        y++;
      }
    }
  }

  Future<StaggeredTile> addNewIItem(StaggeredTile newStaggeredTile) async {
    StaggeredTile newTile = findEmptyPositionForNewItem(newStaggeredTile); // Adjust the size as needed

    staggeredTiles.add(newTile);

    // for (int i = 0; i < staggeredTiles.length; i++) {
    //   printOkStatus(staggeredTiles[i].mainAxisCellCount);
    // }

    return newTile;
  }
}




/*
When adding a new grid item in a staggered grid in Flutter, you'll need to find an empty position in the grid to place the item. A staggered grid typically consists of different-sized grid items, and you want to find a position where the new item can fit without overlapping with existing items. You can achieve this by using packages like `flutter_staggered_grid_view`.

Here's a step-by-step guide on how to find an empty position for a new grid item in a staggered grid:

1. Add the `flutter_staggered_grid_view` package to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_staggered_grid_view: ^0.4.0
```

2. Import the package in your Dart code:

```dart
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
```

3. Create a list of grid items with different sizes (width and height). These items can represent your existing grid items.

```dart
List<StaggeredTile> _existingGridItems = [
  StaggeredTile.count(2, 2),
  StaggeredTile.count(1, 2),
  StaggeredTile.count(1, 1),
  // Add more existing grid items here
];
```

4. Create a `StaggeredGridView` widget to display the existing items. Use the `staggeredTiles` property to specify the sizes of the existing items.

```dart
StaggeredGridView.count(
  crossAxisCount: 4, // The number of columns in the grid
  staggeredTiles: _existingGridItems, // Sizes of existing items
  children: <Widget>[
    // Your existing grid items' widgets
  ],
);
```

5. When adding a new item, determine its size (StaggeredTile) and find an empty position for it in the grid. You can use a function like this:

```dart
StaggeredTile findEmptyPositionForNewItem(StaggeredTile newItem) {
  int x = 0; // Start from the first column
  int y = 0; // Start from the top row

  while (true) {
    // Check if the current position is empty
    bool positionIsOccupied = _existingGridItems.any((tile) {
      return tile.crossAxisCell + x <= 4 && tile.mainAxisCell + y <= 4;
    });

    if (!positionIsOccupied) {
      return StaggeredTile.count(newItem.crossAxisCell, newItem.mainAxisCell, x: x, y: y);
    }

    // Move to the next position in the grid
    x++;
    if (x >= 4) {
      x = 0;
      y++;
    }
  }
}
```

6. Use the `findEmptyPositionForNewItem` function to find an empty position for your new grid item and add it to the `_existingGridItems` list:

```dart
StaggeredTile newTile = findEmptyPositionForNewItem(StaggeredTile.count(2, 2)); // Adjust the size as needed
_existingGridItems.add(newTile);
```

7. Update your `StaggeredGridView` with the new list of `_existingGridItems`:

```dart
StaggeredGridView.count(
  crossAxisCount: 4,
  staggeredTiles: _existingGridItems,
  children: <Widget>[
    // Your existing and new grid items' widgets
  ],
);
```

This way, you can find an empty position for a new grid item in a staggered grid in Flutter and ensure it doesn't overlap with existing items.







 */