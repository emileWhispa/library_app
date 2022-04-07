class Kid{
  int id;
  String? name;
  String? age;

  Kid.fromJson(Map<String,dynamic> map):id = map['id'],name = map['KidName'],age = map['KidAgeRange'];


  String get subName=>(name??"").length>3 ? name!.substring(0,3) : name??"";
}