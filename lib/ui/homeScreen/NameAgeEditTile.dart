import 'package:employees/netwok/WebService.dart';
import 'package:employees/ui/EditEmployee/EditEmployee.dart';
import 'package:flutter/material.dart';

Color color = Colors.purple;

class NameAgeEditTile extends StatelessWidget {
  final employee, index;

  const NameAgeEditTile({Key key, this.index, this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        trailing: FittedBox(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditEmployee(
                          employee: employee,
                          index: index,
                        ),
                      ));
                },
                child: Icon(Icons.edit, color: color),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: GestureDetector(
                  onTap: () async{
                   await Webservice()
                        .deleteData(id: int.parse(employee.data[index].id)).then((value){
                          if(value){
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("delete"),
                                content: Text(
                                    "${employee.data[index].employeeName} is deleted"),
                              ),
                            );
                          }
                          else{
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(

                                title: Text("delete"),
                                content: Text(
                                    "${employee.data[index].employeeName} cannot be deleted"),
                              ),
                            );
                          }
                   });

                  },
                  child: Icon(Icons.delete, color: color),
                ),
              ),
            ],
          ),
        ),
        title: Container(
            height: MediaQuery.of(context).size.height / 13,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 15),
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10),
            child: Text(
              "${employee.data[index].employeeName}",
              style: TextStyle(
                color: color,
              ),
            )),
        subtitle: Container(
            padding: EdgeInsets.only(left: 15),
            child: Text("Age: ${employee.data[index].employeeAge}")),
      ),
    );
  }
}
