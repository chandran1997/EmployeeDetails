import 'package:employee/Screens/employeeDetailsScreen.dart';
import 'package:employee/appProvider/EmployeeProvider.dart';
import 'package:employee/sharedPrefrence/sharedprefrance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedAppPrefrence.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmployeeViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: EmployeeDetailsScreen(),
      ),
    );
  }
}
