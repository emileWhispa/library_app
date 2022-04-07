class Book {
  String image;
  int id;
  String name;
  String? lang;
  String? category;

  Book.fromJson(Map<String, dynamic> map)
      : image = map['BookImage'],
        id = map['id'],
        name = map['BookName'],
        lang = map['BookLanguage'],
        category = map['BookCategoryName'];


  Map<String,dynamic> toJson()=>{
    "BookImage":image,
    "id":id,
    "BookName":name,
    "BookCategoryName":category
  };
}
