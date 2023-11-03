// /* import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// import 'controller/base_controller.dart';
// import 'res/app_colors.dart';
// import 'res/app_strings.dart';
// import 'res/app_theme.dart';
// import 'res/color_print.dart';
// import 'route/app_pages.dart';
// import 'route/app_routes.dart';
// import 'utils/local_storage.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await GetStorage.init();
//   await LocalStorage.readDataInfo();
//   await SystemChrome.setPreferredOrientations(
//     [
//       DeviceOrientation.portraitDown,
//       DeviceOrientation.portraitUp,
//     ],
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(360, 690),
//       builder: (context, child) {
//         return GetMaterialApp(
//           title: AppStrings.appName,
//           debugShowCheckedModeBanner: false,
//           initialBinding: LazyBinding(),
//           themeMode: ThemeMode.light,
//           theme: AppTheme.lightMode(
//             kPrimaryColor: AppColors.kPrimaryColor,
//             kBackgroundColor: AppColors.kBackgroundColor,
//             errorColor: AppColors.errorColor,
//             fontFamily: AppTheme.fontFamilyName,
//           ),
//           darkTheme: AppTheme.darkMode(
//             kPrimaryColor: AppColors.kPrimaryColor,
//             kBackgroundColor: AppColors.kBackgroundColor,
//             errorColor: AppColors.errorColor,
//             fontFamily: AppTheme.fontFamilyName,
//           ),
//           getPages: AppPages.pages,
//           initialRoute: AppRoutes.splashScreen,
//         );
//       },
//     );
//   }
// }

// class LazyBinding implements Bindings {
//   @override
//   void dependencies() {
//     Get.put(BaseController(), permanent: true);
//     printData(key: "Get.put", value: BaseController);
//   }
// } */

// import 'package:flutter/material.dart';
// import 'package:spannable_grid/spannable_grid.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SpannableGrid Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blueGrey,
//       ),
//       home: const MyHomePage(title: 'SpannableGrid Demo'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   bool _singleCell = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SpannableGrid(
//               columns: 2,
//               rows: 2,
//               cells: _getCells(),
//               onCellChanged: (cell) {
//                 // print('Cell ${cell.id} changed');
//               },
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextButton(
//                 child: const Text('Change'),
//                 onPressed: () {
//                   setState(() {
//                     _singleCell = !_singleCell;
//                   });
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<SpannableGridCellData> _getCells() {
//     var result = <SpannableGridCellData>[];
//     if (_singleCell) {
//       result.add(SpannableGridCellData(
//         column: 1,
//         row: 1,
//         columnSpan: 2,
//         rowSpan: 2,
//         id: "Test Cell 1",
//         child: Container(
//           color: Colors.lime,
//           child: Center(
//             child: Text(
//               "Tile 4x4",
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//           ),
//         ),
//       ));
//     } else {
//       result.add(SpannableGridCellData(
//         column: 1,
//         row: 1,
//         columnSpan: 2,
//         rowSpan: 2,
//         id: "Test Cell 1",
//         child: Container(
//           color: Colors.lime,
//           child: Center(
//             child: Text(
//               "Tile 2x2",
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//           ),
//         ),
//       ));
//       result.add(SpannableGridCellData(
//         column: 2,
//         row: 1,
//         columnSpan: 1,
//         rowSpan: 1,
//         id: "Test Cell 2",
//         child: Container(
//           color: Colors.lime,
//           child: Center(
//             child: Text(
//               "Tile 1x1",
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//           ),
//         ),
//       ));
//       result.add(SpannableGridCellData(
//         column: 1,
//         row: 2,
//         columnSpan: 1,
//         rowSpan: 1,
//         id: "Test Cell 3",
//         child: Container(
//           color: Colors.lightBlueAccent,
//           child: Center(
//             child: Text(
//               "Tile 3x1",
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//           ),
//         ),
//       ));
//       result.add(SpannableGridCellData(
//         column: 2,
//         row: 1,
//         columnSpan: 1,
//         rowSpan: 2,
//         id: "Test Cell 4",
//         child: Container(
//           color: Colors.lightBlueAccent,
//           child: Center(
//             child: Text(
//               "Tile 1x2",
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//           ),
//         ),
//       ));
//     }
//     return result;
//   }
// }
