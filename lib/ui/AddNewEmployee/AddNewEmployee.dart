 import 'package:employees/model/Data.dart';
import 'package:employees/model/Employee.dart';
import 'package:employees/netwok/WebService.dart';
import 'package:employees/ui/WidgetsCreated/createAppBar.dart';
import 'package:employees/ui/homeScreen/NameAgeEditTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewEmployee extends StatefulWidget {
  AddNewEmployee({Key key}) : super(key: key);

  @override
  _AddNewEmployeeState createState() => _AddNewEmployeeState();
}

class _AddNewEmployeeState extends State<AddNewEmployee> {
  var employeeController = TextEditingController();
  var ageController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    employeeController.dispose();
    ageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(title: "Add Employee"),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              controller: employeeController,
              enabled: true,

              decoration: InputDecoration(
                hintText: "Employee Name",

              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: ageController,
              enabled: true,
              decoration: InputDecoration(
                hintText: "Employee Age",

              ),
            ),
            SizedBox(height: 15,),
            CupertinoButton(

              padding: EdgeInsets.symmetric(horizontal: 25,),
              color: color,
              child: Text("Save"),
                onPressed: () {
                final body={
                  'name':employeeController.text,
                  'age':ageController.text,
                };
                Webservice().addData(body).then((value){
                  if(value==true && ageController.text.isNotEmpty&& employeeController.text.isNotEmpty)
                    { showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Adding...."),
                        content:Row(
                          children: [
                            Text("Employee added   "),
                            Icon(CupertinoIcons.checkmark),
                          ],

                        ),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                              employeeController.text = '';
                              ageController.text = '';
                            },
                            child: Text('OK'),
                          )
                        ],
                      ),);
                    }
                  else{
                    showDialog(
                      builder: (context) => AlertDialog(
                        title: Text('Error Adding Employee!!!'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          )
                        ],
                      ),
                      context: context,
                    );
                  }
                });

                  
                },)
          ],

        ),
      ),
    );
  }
}