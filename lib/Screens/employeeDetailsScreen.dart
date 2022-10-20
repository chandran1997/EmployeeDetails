import 'package:connectivity/connectivity.dart';
import 'package:employee/Model/ResEmployeeDetails.dart';
import 'package:employee/Screens/viewEmployee_details.dart';
import 'package:employee/appProvider/EmployeeProvider.dart';
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
                Expanded(
                  child: _tabbarWidget(viewModel),
                )
              ],
            ),
          );
        });
      },
    );
  }

  Widget _tabbarWidget(EmployeeViewModel viewModel) {
    var employeeDetails = viewModel.employeeDetails;

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
                viewModel.searchResult(val, viewModel.isOnline);
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
