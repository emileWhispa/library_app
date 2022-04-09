import 'package:library_app/json/plan.dart';

class User {
  String? token;
  String? email;
  String? phone;
  String? fName;
  String? lName;
  String? role;
  int id;

  static User? user;

  User.fromJson(Map<String, dynamic> map,{String userKey='user'})
      : token = map['access_token'],
        phone = map[userKey]['phone_number'],
        fName = map[userKey]['name'],
        role = map[userKey]['role'],
        id = map[userKey]['id'],
        lName = map[userKey]['name'],
        email = map[userKey]['email'];

  Map<String,dynamic> toJson()=>{
    "access_token":token,
    "user":{
      "phone_number":phone,
      "name":fName,
      "role":role,
      "id":id,
      "email":email,
    }
  };


  bool get hasPhoneAndEmail=>email != null && phone != null;

  Plan? plan;


  String get name=>fName??"";

  String get shortName => name.length>2?name.substring(0,2) : name;
}
