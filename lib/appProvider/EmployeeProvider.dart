// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:employee/Model/ResEmployeeDetails.dart';
import 'package:employee/NetWorking/Repository.dart';
import 'package:employee/sharedPrefrence/sharedprefrance.dart';
import 'package:flutter/cupertino.dart';
import 'package:connectivity/connectivity.dart';

class EmployeeViewModel extends ChangeNotifier {
  EmployeeRepository _repository = EmployeeRepository();

  ResEmployeeList _details = ResEmployeeList();
  ResEmployeeList get employeeDetails => _details;

  List<ResEmployeeDetails>? _searchList = List.empty(growable: true);
  List<ResEmployeeDetails>? get searchList => _searchList;

  bool? isOnline = false;

  Connectivity _connectivity = new Connectivity();

  getEmployeeDetailss() async {
    try {
      _connectivity.onConnectivityChanged
          .listen((ConnectivityResult result) async {
        if (result == ConnectivityResult.wifi ||
            result == ConnectivityResult.mobile) {
          var response = await _repository.getemployeeDetails();
          isOnline = true;
          _details = response;
          SharedAppPrefrence.getData(_details);
          print("IS_ONLINE $isOnline");
          notifyListeners();
        } else {
          isOnline = false;
          await prefrenceData();
          print("IS_ONLINE $isOnline");
          notifyListeners();
        }
      });
      await prefrenceData();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  void searchResult(String name, bool? isOnline) async {
    if (name.isEmpty) {
      _searchList?.clear();
    } else {
      var tempList = _details.data?.where((e) {
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
      // SharedPreferences preferences = await SharedPreferences.getInstance();
      // var d = preferences.getString(SharedAppPrefrence.GET_EMPLOYEE_DATA);
      var d = SharedAppPrefrence.data();
      print(d.toString());
      var covert = jsonDecode(d ?? "");
      _details = ResEmployeeList.fromJson(covert);
      print("${_details.data?.map((e) => e.name)}==========>");
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
}
