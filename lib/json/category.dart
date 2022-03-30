class Category {
  String name;
  String image;
  int id;

  Category.fromJson(Map<String, dynamic> map)
      : name = map['BookCategoryName'],
        image = map['BookCategoryImage'],
        id = map['id'];
}
