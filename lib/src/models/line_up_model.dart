
import 'package:truck/src/models/api_response_model.dart';

class Lineup {
    AwayClass? team;
    String? formation;
    List<StartXi>? startXi;
    List<StartXi>? substitutes;
    Coach? coach;

    Lineup({
        this.team,
        this.formation,
        this.startXi,
        this.substitutes,
        this.coach,
    });

    factory Lineup.fromJson(Map<String, dynamic> json) => Lineup(
        team: json["team"] == null ? null : AwayClass.fromJson(json["team"]),
        formation: json["formation"],
        startXi: json["startXI"] == null ? [] : List<StartXi>.from(json["startXI"]!.map((x) => StartXi.fromJson(x))),
        substitutes: json["substitutes"] == null ? [] : List<StartXi>.from(json["substitutes"]!.map((x) => StartXi.fromJson(x))),
        coach: json["coach"] == null ? null : Coach.fromJson(json["coach"]),
    );

    Map<String, dynamic> toJson() => {
        "team": team?.toJson(),
        "formation": formation,
        "startXI": startXi == null ? [] : List<dynamic>.from(startXi!.map((x) => x.toJson())),
        "substitutes": substitutes == null ? [] : List<dynamic>.from(substitutes!.map((x) => x.toJson())),
        "coach": coach?.toJson(),
    };
}
