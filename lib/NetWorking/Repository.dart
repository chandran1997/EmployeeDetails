import 'package:employee/Model/ResEmployeeDetails.dart';
import 'package:employee/NetWorking/ApiUrl.dart';
import 'package:employee/NetWorking/HttpClient.dart';

class EmployeeRepository {
  Future<ResEmployeeList> getemployeeDetails() async {
    final response = await HttpClient.instance.fetchData(AppUrls.endPoint);
    return ResEmployeeList.fromJson(response);
  }
}
