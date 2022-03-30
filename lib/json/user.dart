class User {
  String? token;
  String? email;
  String? phone;
  String? fName;
  String? lName;

  static User? user;

  User.fromJson(Map<String, dynamic> map)
      : token = map['access_token'],
        phone = map['user']['phone_number'],
        fName = map['user']['name'],
        lName = map['user']['name'],
        email = map['user']['email'];


  bool get hasPhoneAndEmail=>email != null && phone != null;
}
