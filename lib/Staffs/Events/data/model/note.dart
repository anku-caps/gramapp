class Note {
  final String title;
  final String description;
  final String date;
  final String id;

  Note({this.title, this.description, this.id, this.date});

  Note.fromMap(Map<String, dynamic> data, String id)
      : title = data["title"],
        description = data['description'],
        date = data['date'],
        id = id;

  Map<String, dynamic> toMap() {
    return {"title": title, "description": description, "date": date};
  }
}
