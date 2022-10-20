import 'dart:convert';

import 'package:employee_directory/Model/ResEmployeeDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedAppPrefrence {
  static const String GET_EMPLOYEE_DATA = "get_employee_data";

  static getData(ResEmployeeList data) async {
    SharedPreferences prefrence = await SharedPreferences.getInstance();
    // data = val.toJson();
    var jsonFormate = jsonEncode(data.toJson());
    await prefrence.setString(GET_EMPLOYEE_DATA, jsonFormate);
  }
}
