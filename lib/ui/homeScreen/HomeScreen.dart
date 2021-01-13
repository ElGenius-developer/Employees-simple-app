import 'package:employees/model/Employee.dart';
import 'package:employees/netwok/WebService.dart';
import 'package:employees/ui/AddNewEmployee/AddNewEmployee.dart';
import 'package:employees/ui/WidgetsCreated/createAppBar.dart';
import 'package:employees/ui/homeScreen/NameAgeEditTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class HomeScreen extends StatefulWidget {
  final title;
  HomeScreen({this.title});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var employee = new Employees();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(title: widget.title),
      body: Container(
        child: FutureBuilder(
          future: Webservice().getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              employee = snapshot.data;
              return ListView.builder(
                itemCount: employee.data.length,
                itemBuilder: (context, index) => NameAgeEditTile(
                  index: index,
                  employee: employee,
                ),
              );
            } else {
              return Center(
                  child: Container(
                height: 100,
                width: 100,
                child: LiquidCircularProgressIndicator(
                  value: .35, // Defaults to// 0.5.

                  valueColor: AlwaysStoppedAnimation(Colors
                      .purpleAccent), // Defaults to the current Theme's accentColor.
                  backgroundColor: Colors
                      .white, // Defaults to the current Theme's backgroundColor.
                  borderColor: Colors.purpleAccent,
                  borderWidth: 5.0,
                  direction: Axis
                      .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                  center: Text("Loading..."),
                ),
              ));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
         await Navigator.push(context,
              CupertinoPageRoute(builder: (context) => AddNewEmployee()));
        },
        backgroundColor: color,
        tooltip: "Add new ",
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
