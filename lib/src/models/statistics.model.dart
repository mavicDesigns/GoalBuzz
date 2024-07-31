
import 'package:truck/src/models/api_response_model.dart';

class Statistics {
    AwayClass? team;
    List<TeamStats>? statistics;

    Statistics({
        this.team,
        this.statistics,
    });

    factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        team: json["team"] == null ? null : AwayClass.fromJson(json["team"]),
        statistics: json["statistics"] == null ? [] : List<TeamStats>.from(json["statistics"]!.map((x) => TeamStats.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "team": team?.toJson(),
        "statistics": statistics == null ? [] : List<dynamic>.from(statistics!.map((x) => x.toJson())),
    };
}

class TeamStats {
    String? type;
    dynamic value;

    TeamStats({
        this.type,
        this.value,
    });

    factory TeamStats.fromJson(Map<String, dynamic> json) => TeamStats(
        type: json["type"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
    };
}
