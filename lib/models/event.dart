class Event {
  static String tablename = "events";
  int? id;
  String title;
  DateTime dateDebut;
  DateTime dateFin;
  String type;
  String lieu;
  String? chosesApporter;

  Event({
    this.id,
    required this.title,
    required this.dateDebut,
    required this.dateFin,
    required this.type,
    required this.lieu,
    this.chosesApporter,
  });

  Event.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        dateDebut = DateTime.parse(json["date_debut"]),
        dateFin = DateTime.parse(json["date_fin"]),
        type = json["type"],
        lieu = json["lieu"],
        chosesApporter = json["choses_apporter"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "date_debut": dateDebut.toIso8601String(),
      "date_fin": dateFin.toIso8601String(),
      "type": type,
      "lieu": lieu,
      "choses_apporter": chosesApporter,
    };
  }
}
