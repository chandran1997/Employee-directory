import 'package:employee_directory/Model/ResEmployeeDetails.dart';
import 'package:flutter/material.dart';

class ViewEmployeeDetails extends StatelessWidget {
  ResEmployeeDetails model;
  ViewEmployeeDetails(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("View Employee Details"),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Container(
              height: 100,
              width: 100,
              child: model.profileImage != null
                  ? Image.network(model.profileImage ?? "")
                  : Image.asset("assets/avatar.jpeg"),
            ),
            SizedBox(height: 14),
            Text("USER DETAILS :",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
            SizedBox(height: 10),
            rowText("Name", model.name ?? ""),
            SizedBox(height: 10),
            rowText("User Name", model.username ?? ""),
            SizedBox(height: 10),
            rowText("Email Address", model.email ?? ""),
            SizedBox(height: 10),
            rowText("Phone", model.phone ?? ""),
            SizedBox(height: 10),
            rowText("Website", model.website ?? ""),
            SizedBox(height: 14),
            Text("ADDRESS :",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
            SizedBox(height: 10),
            rowText("Street", model.address?.street ?? ""),
            SizedBox(height: 10),
            rowText("Suite", model.address?.suite ?? ""),
            SizedBox(height: 10),
            rowText("City", model.address?.city ?? ""),
            SizedBox(height: 10),
            rowText("zipcode", model.address?.zipcode ?? ""),
            SizedBox(height: 14),
            Text("COMPANY :",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
            SizedBox(height: 10),
            rowText("Name", model.company?.name ?? ""),
            SizedBox(height: 10),
            rowText("Catch Phrase", model.company?.catchPhrase ?? ""),
            SizedBox(height: 10),
            rowText("BS", model.company?.bs ?? ""),
          ],
        ),
      ),
    );
  }

  static Widget rowText(String title, String details) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
            )),
        Expanded(
            flex: 3,
            child: Text(
              "  :  " + details,
              style: TextStyle(fontSize: 12),
            ))
      ],
    );
  }
}
