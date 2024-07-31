
import 'package:truck/src/models/api_response_model.dart';

class Event {
    Time? time;
    AwayClass? team;
    Assist? player;
    Assist? assist;
    Type? type;
    String? detail;
    String? comments;

    Event({
        this.time,
        this.team,
        this.player,
        this.assist,
        this.type,
        this.detail,
        this.comments,
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        time: json["time"] == null ? null : Time.fromJson(json["time"]),
        team: json["team"] == null ? null : AwayClass.fromJson(json["team"]),
        player: json["player"] == null ? null : Assist.fromJson(json["player"]),
        assist: json["assist"] == null ? null : Assist.fromJson(json["assist"]),
        type: typeValues.map[json["type"]]!,
        detail: json["detail"],
        comments: json["comments"],
    );

    Map<String, dynamic> toJson() => {
        "time": time?.toJson(),
        "team": team?.toJson(),
        "player": player?.toJson(),
        "assist": assist?.toJson(),
        "type": typeValues.reverse[type],
        "detail": detail,
        "comments": comments,
    };
}
