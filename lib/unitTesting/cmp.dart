// import 'package:bus_management_admin/unitTesting/BusListPage.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: BusTestPage());
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:sizer/sizer.dart';

// import 'unitTesting/layoutBus/adbus.dart';
// import 'unitTesting/layoutBus/all_code.dart';

// /// ----------------------
// /// MAIN ENTRY POINT
// /// ----------------------
// void main() {
//   runApp(
//     const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: BusLayoutSelectionScreen(),
//     ),
//   );
// }

// void main() {
//   runApp(const BusApp());
// }

// class BusApp extends HookWidget {
//   const BusApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Dynamic Bus Layout Demo',
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//             scaffoldBackgroundColor: Colors.white,
//             inputDecorationTheme: InputDecorationTheme(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//           ),
//           home: const AddBusScreen(),
//         );
//       },
//     );
//   }
// }
