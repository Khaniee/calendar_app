class Task {
  static String tablename = "tasks";

  int? id;
  String title;
  bool isDone;
  DateTime hour;

  Task({
    this.id,
    required this.title,
    required this.hour,
    this.isDone = false,
  });

  Task.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        isDone = json["is_done"] == 1 ? true : false,
        hour = DateTime.parse(json["hour"]);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "is_done": isDone,
      "hour": hour.toIso8601String(),
    };
  }
}
