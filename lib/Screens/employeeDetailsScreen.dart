import 'package:employee_directory/Model/ResEmployeeDetails.dart';
import 'package:employee_directory/Screens/viewEmployee_details.dart';
import 'package:employee_directory/appProvider/EmployeeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  const EmployeeDetailsScreen({super.key});

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _controller = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EmployeeViewModel>(
      create: (_) {
        var provider = EmployeeViewModel();
        provider.getEmployeeDetailss();
        Future.delayed(Duration(seconds: 3), () {
          provider.prefrenceData();
        });

        return provider;
      },
      builder: (_, __) {
        return Consumer<EmployeeViewModel>(builder: (_, viewModel, __) {
          return Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text("Employee Details"),
              ),
            ),
            body: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: TabBar(
                    unselectedLabelColor: Colors.black45,
                    labelColor: Colors.blueAccent,
                    indicatorColor: Colors.blueAccent,
                    labelStyle: Theme.of(context).textTheme.headline5,
                    tabs: [
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          "API",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text("Shared Prefrence",
                              style: TextStyle(fontSize: 14))),
                    ],
                    controller: _tabController,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _tabbarWidget(viewModel, false),
                      _tabbarWidget(viewModel, true),
                    ],
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }

  Widget _tabbarWidget(EmployeeViewModel viewModel, bool? isSharedPrefrence) {
    var employeeDetails = isSharedPrefrence ?? false
        ? viewModel.prefrerenceList
        : viewModel.employeeDetails;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5, right: 5, top: 10),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: _controller,
              onChanged: (val) {
                viewModel.searchResult(val, isSharedPrefrence);
              },
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                hintText: "Search the Employee",
              ),
            ),
          ),
        ),

        SizedBox(height: 20),
        //body
        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: viewModel.searchList!.isNotEmpty ||
                      _controller.text.isNotEmpty
                  ? viewModel.searchList?.length
                  : employeeDetails.data?.length,
              itemBuilder: (context, index) {
                var data = viewModel.searchList!.isNotEmpty ||
                        _controller.text.isNotEmpty
                    ? viewModel.searchList![index]
                    : employeeDetails.data?[index];
                return Card(
                  elevation: 4,
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewEmployeeDetails(
                                    data ?? ResEmployeeDetails())));
                      },
                      child: ListTile(
                        title: Text(data?.name ?? ""),
                        subtitle: Text(data?.company?.name ?? ""),
                        leading: Container(
                          height: 50,
                          width: 50,
                          child: data?.profileImage != null
                              ? Image.network(data?.profileImage ?? "")
                              : Image.asset("assets/avatar.jpeg"),
                        ),
                        trailing:
                            Icon(Icons.arrow_forward, color: Colors.blueAccent),
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
