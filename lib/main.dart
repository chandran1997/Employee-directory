import 'package:employee_directory/Screens/employeeDetailsScreen.dart';
import 'package:employee_directory/appProvider/EmployeeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => EmployeeViewModel())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: EmployeeDetailsScreen(),
      ),
    );
  }
}
