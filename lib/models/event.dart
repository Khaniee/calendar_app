class Event {
  static String tablename = "events";
  int? id;
  final String title;
  final DateTime date_debut;
  final DateTime date_fin;
  final String type;
  final String lieu;
  final String choses_apporter;

  Event(
    this.id,
    this.title,
    this.date_debut,
    this.date_fin,
    this.type,
    this.lieu,
    this.choses_apporter,
  );

  Event.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        date_debut = DateTime.parse(json["date_debut"]),
        date_fin = DateTime.parse(json["date_fin"]),
        type = json["type"],
        lieu = json["lieu"],
        choses_apporter = json["choses_apporter"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "date_debut": date_debut.toIso8601String(),
      "date_fin": date_fin.toIso8601String(),
      "type": type,
      "lieu": lieu,
      "choses_apporter": choses_apporter,
    };
  }
}
