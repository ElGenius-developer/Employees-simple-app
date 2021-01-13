import 'dart:convert';
import 'package:employees/model/Data.dart';
import 'package:employees/model/Employee.dart';
import 'package:http/http.dart' as http ;

final String baseUrl = 'http://dummy.restapiexample.com/api/v1/';
var data = new Data();
var header= { "Accept" : "application/json"};
class  Webservice {

 Future<Employees> getData () async{
    String getEndPoint='employees';
final response = await http.get(baseUrl+getEndPoint);
 
    if(response.statusCode==200)
      {
        final json = jsonDecode(response.body);
       return  Employees.fromJson(json);
      }
    else{
      throw Exception("Cannot load Data");
    }


  }
    Future<bool> addData(var body) async{
   String createUrl=baseUrl+'create';
    final response = await http.post(createUrl, body: body);
   if(response.statusCode==200) {
      return true;
    } else {
      return false;
    }
  }

   Future<bool> editData({int id, var body}) async{

   String putUrl= baseUrl+'update/$id';

   final response = await http.put(putUrl,headers: header,body:body );
    if(response.statusCode==200)
     return true;
   else
     return false;
   }

 Future<bool> deleteData({int id}) async{

   String deleteUrl= baseUrl+'delete/$id';
   final response = await http.delete(deleteUrl);
    if(response.statusCode==200)
     return true;
   else
     return false;
 }






}