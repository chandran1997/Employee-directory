import 'package:employee_directory/Model/ResEmployeeDetails.dart';
import 'package:employee_directory/NetWorking/ApiUrl.dart';
import 'package:employee_directory/NetWorking/HttpClient.dart';

class EmployeeRepository {
  Future<ResEmployeeList> getemployeeDetails() async {
    final response = await HttpClient.instance.fetchData(AppUrls.endPoint);
    return ResEmployeeList.fromJson(response);
  }
}
