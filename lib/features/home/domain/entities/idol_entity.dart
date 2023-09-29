import 'dart:convert';

class IdolEntity {
  String id;
  String name;
  String hangul;
  Gender gender;
  DateTime birthday;
  DateTime? debut;
  bool active;
  String avatar;
  int v;
  List<Profession> profession;
  String? fullName;
  String? nativeName;
  String? fandom;
  DateTime? updatedAt;
  dynamic group;

  IdolEntity({
    required this.id,
    required this.name,
    required this.hangul,
    required this.gender,
    required this.birthday,
    required this.debut,
    required this.active,
    required this.avatar,
    required this.v,
    required this.profession,
    this.fullName,
    this.nativeName,
    this.fandom,
    this.updatedAt,
    required this.group,
  });

  factory IdolEntity.fromJson(String str) =>
      IdolEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IdolEntity.fromMap(Map<String, dynamic> json) => IdolEntity(
        id: json["_id"],
        name: json["name"],
        hangul: json["hangul"],
        gender: genderValues.map[json["gender"]]!,
        birthday: DateTime.parse(json["birthday"]),
        debut: json["debut"] == null ? null : DateTime.parse(json["debut"]),
        active: json["active"],
        avatar: json["avatar"],
        v: json["__v"],
        profession: List<Profession>.from(
            json["profession"].map((x) => professionValues.map[x]!)),
        fullName: json["fullName"],
        nativeName: json["nativeName"],
        fandom: json["fandom"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        group: json["group"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "hangul": hangul,
        "gender": genderValues.reverse[gender],
        "birthday": birthday.toIso8601String(),
        "debut": debut?.toIso8601String(),
        "active": active,
        "avatar": avatar,
        "__v": v,
        "profession": List<dynamic>.from(
            profession.map((x) => professionValues.reverse[x])),
        "fullName": fullName,
        "nativeName": nativeName,
        "fandom": fandom,
        "updatedAt": updatedAt?.toIso8601String(),
        "group": group,
      };
}

enum Gender { F }

final genderValues = EnumValues({"F": Gender.F});

enum Profession { A, I }

final professionValues = EnumValues({"A": Profession.A, "I": Profession.I});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
