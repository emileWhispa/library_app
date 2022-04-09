class Plan {
  int id;
  String name;
  num amount;
  int allowedBooks;
  int period;
  String? level;
  String? date;

  Plan.fromJson(Map<String, dynamic> map)
      :id = map['id'],
        name = map['membershipName'] ?? map['MembershipName'],
        period = int.tryParse("${map['membershipPeriod'] ?? map['MembershipPeriod']}") ?? 0,
  level = map['MembershipLevel'],
  date = map['membership_end_date'],
  amount = num.tryParse("${map['membershipAmount']}") ?? 0.0,
  allowedBooks = int.tryParse("${map['membershipAllowedBooks']}") ?? 0;


  Map<String,dynamic> toJson()=>{
    "id":id,
    "membershipName":name,
    "membershipPeriod":period,
    "MembershipLevel":level,
    "membershipAmount":amount,
    "membership_end_date":date,
    "membershipAllowedBooks":allowedBooks,
  };
}