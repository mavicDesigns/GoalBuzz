
import 'package:truck/src/models/api_response_model.dart';

class Score {
    TeamsClass? halftime;
    TeamsClass? fulltime;
    TeamsClass? extratime;
    TeamsClass? penalty;

    Score({
        this.halftime,
        this.fulltime,
        this.extratime,
        this.penalty,
    });

    factory Score.fromJson(Map<String, dynamic> json) => Score(
        halftime: json["halftime"] == null ? null : TeamsClass.fromJson(json["halftime"]),
        fulltime: json["fulltime"] == null ? null : TeamsClass.fromJson(json["fulltime"]),
        extratime: json["extratime"] == null ? null : TeamsClass.fromJson(json["extratime"]),
        penalty: json["penalty"] == null ? null : TeamsClass.fromJson(json["penalty"]),
    );

    Map<String, dynamic> toJson() => {
        "halftime": halftime?.toJson(),
        "fulltime": fulltime?.toJson(),
        "extratime": extratime?.toJson(),
        "penalty": penalty?.toJson(),
    };
}
