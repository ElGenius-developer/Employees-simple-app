 import 'package:employees/model/Employee.dart';
import 'package:employees/netwok/WebService.dart';
 import 'package:employees/ui/WidgetsCreated/createAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../homeScreen/NameAgeEditTile.dart';
var _emp = Employees();// just shortcut
class EditEmployee extends StatefulWidget {
  final employee, index;

  const EditEmployee({Key key, this.employee, this.index}) : super(key: key);
  @override
  _EditEmployeeState createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee>  {
  var employeeController =TextEditingController();
  var ageController =TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _emp =widget.employee;

      employeeController.text=_emp.data[widget.index].employeeName;
      ageController.text=_emp.data[widget.index].employeeAge;
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    employeeController.dispose();
    ageController.dispose();
  }

  @override
  Widget build(context) {


    return Scaffold(
       appBar: createAppBar(title:" Edit Employee"),
       body:Column(
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
               Webservice().editData(id: int.parse( _emp.data[widget.index].id),body: body ).then((value){
                 if(value==true && ageController.text.isNotEmpty&& employeeController.text.isNotEmpty)
                 { showDialog(
                   context: context,
                   builder: (context) => AlertDialog(
                     title: Text("Editing...."),
                     content:Row(
                       children: [
                         Text("Employee Edited   "),
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
                 }else {
                   showDialog(
                     builder: (context) => AlertDialog(
                       title: Text('Error Editing Employee!!!'),
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

       ) ,
    );
  }
}
