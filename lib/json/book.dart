class Book{
  String image;
  int id;
  String name;
  String? category;

  Book.fromJson(Map<String,dynamic> map):image = map['BookImage'],id = map['id'],name = map['BookName'],category = map['BookCategoryName'];
}