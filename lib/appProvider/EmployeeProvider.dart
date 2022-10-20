// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:employee_directory/Model/ResEmployeeDetails.dart';
import 'package:employee_directory/NetWorking/ApiUrl.dart';
import 'package:employee_directory/NetWorking/Repository.dart';
import 'package:employee_directory/sharedPrefrence/sharedprefrance.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeViewModel extends ChangeNotifier {
  EmployeeRepository _repository = EmployeeRepository();

  ResEmployeeList _details = ResEmployeeList();
  ResEmployeeList get employeeDetails => _details;

  List<ResEmployeeDetails>? _searchList = List.empty(growable: true);
  List<ResEmployeeDetails>? get searchList => _searchList;

  ResEmployeeList _preferenceList = ResEmployeeList();
  ResEmployeeList get prefrerenceList => _preferenceList;

  getEmployeeDetailss() async {
    try {
      var response = await _repository.getemployeeDetails();
      _details = response;

      if (response != null) {
        SharedAppPrefrence.getData(_details);
      }

      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void searchResult(String name, bool? isSharedPreference) async {
    if (name.isEmpty) {
      _searchList?.clear();
    } else {
      var tempList = isSharedPreference ?? false
          ? _preferenceList.data?.where((e) {
              return e.name!.toLowerCase().contains(name.toLowerCase()) ||
                  e.email!.toLowerCase().contains(name.toLowerCase());
            }).toList()
          : _details.data?.where((e) {
              return e.name!.toLowerCase().contains(name.toLowerCase()) ||
                  e.email!.toLowerCase().contains(name.toLowerCase());
            }).toList();

      _searchList?.clear();
      _searchList?.addAll(tempList ?? []);
    }
    notifyListeners();
  }

  //get prefrence data

  prefrenceData() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var d = preferences.getString(SharedAppPrefrence.GET_EMPLOYEE_DATA);
      print(d.toString());
      var covert = jsonDecode(d ?? "");
      _preferenceList = ResEmployeeList.fromJson(covert);
      print("${_preferenceList.data?.map((e) => e.name)}==========>");
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
}
