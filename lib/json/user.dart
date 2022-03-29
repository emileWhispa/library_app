class User {
  String? token;
  String? email;
  String? phone;
  String? fName;
  String? lName;

  static User? user;

  User.fromJson(Map<String, dynamic> map)
      : token = map['user_token'],
        phone = map['user_phone'],
        fName = map['user_fname'],
        lName = map['user_lname'],
        email = map['user_email'];


  bool get hasPhoneAndEmail=>email != null && phone != null;
}
