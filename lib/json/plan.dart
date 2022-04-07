class Plan {
  int id;
  String name;
  num amount;
  int allowedBooks;
  int period;
  String level;

  Plan.fromJson(Map<String, dynamic> map)
      :id = map['id'],
        name = map['membershipName'],
        period = map['membershipPeriod'],
  level = map['MembershipLevel'],
  amount = num.tryParse("${map['membershipAmount']}") ?? 0.0,
  allowedBooks = int.tryParse("${map['membershipAllowedBooks']}") ?? 0;


  Map<String,dynamic> toJson()=>{
    "id":id,
    "membershipName":name,
    "membershipPeriod":period,
    "MembershipLevel":level,
    "membershipAmount":amount,
    "membershipAllowedBooks":allowedBooks,
  };
}