class Event {
  String image;
  int id;
  String name;
  String description;
  String location;
  String date;

  Event.fromJson(Map<String, dynamic> map)
      : image = map['EventCoverImage'],
        name = map['EventName'],
  description = map['EvenDescription'],
  location = map['EventLocation'],
  date = map['EventDate'],
        id = map['id'];
}
