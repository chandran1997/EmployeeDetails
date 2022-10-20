import 'dart:convert';

import 'package:employee/Model/ResEmployeeDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedAppPrefrence {
  static const String GET_EMPLOYEE_DATA = "get_employee_data";

  static SharedPreferences? _preference;

  static Future init() async =>
      _preference = await SharedPreferences.getInstance();

  static getData(ResEmployeeList data) async {
    SharedPreferences prefrence = await SharedPreferences.getInstance();
    // data = val.toJson();
    var jsonFormate = jsonEncode(data.toJson());
    await _preference?.setString(GET_EMPLOYEE_DATA, jsonFormate);
  }

  static String? data() => _preference?.getString(GET_EMPLOYEE_DATA);
}
