class Kid {
  int id;
  String? name;
  String? age;

  Kid.fromJson(Map<String, dynamic> map, {String? activeId})
      : id = map['id'],
        name = map['KidName'],
        active = activeId == "${map['id']}",
        age = map['KidAgeRange'];

  String get subName =>
      (name ?? "").length > 3 ? name!.substring(0, 3) : name ?? "";

  bool active = false;

  bool loading = false;
}
