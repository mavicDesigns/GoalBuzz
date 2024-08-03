// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);

import 'dart:convert';

import 'package:truck/src/models/event_model.dart';
import 'package:truck/src/models/fixture_model.dart';
import 'package:truck/src/models/league_model.dart';
import 'package:truck/src/models/line_up_model.dart';
import 'package:truck/src/models/players_model.dart';
import 'package:truck/src/models/score_model.dart';
import 'package:truck/src/models/statistics.model.dart';

ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
  String apiResponseGet;
  Parameters parameters;
  List<dynamic> errors;
  int results;
  Paging paging;
  List<Data> data;

  ApiResponse({
    required this.apiResponseGet,
    required this.parameters,
    required this.errors,
    required this.results,
    required this.paging,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        apiResponseGet: json["get"],
        parameters: Parameters.fromJson(json["parameters"]),
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
        results: json["results"],
        paging: Paging.fromJson(json["paging"]),
        data: List<Data>.from(
            json["response"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "get": apiResponseGet,
        "parameters": parameters.toJson(),
        "errors": List<dynamic>.from(errors.map((x) => x)),
        "results": results,
        "paging": paging.toJson(),
        "response": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Paging {
  int current;
  int total;

  Paging({
    required this.current,
    required this.total,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
        current: json["current"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current": current,
        "total": total,
      };
}

class Parameters {
  String? id;

  Parameters({
    this.id,
  });

  factory Parameters.fromJson(Map<String, dynamic> json) => Parameters(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class Data {
  Fixture? fixture;
  League? league;
  TeamsClass? teams;
  TeamsClass? goals;
  Score? score;
  List<Event>? events;
  List<Lineup>? lineups;
  List<Statistics>? statistics;
  List<TeamPlayers>? teamPlayers;

  Data({
    this.fixture,
    this.league,
    this.teams,
    this.goals,
    this.score,
    this.events,
    this.lineups,
    this.statistics,
    this.teamPlayers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        fixture:
            json["fixture"] == null ? null : Fixture.fromJson(json["fixture"]),
        league: json["league"] == null ? null : League.fromJson(json["league"]),
        teams:
            json["teams"] == null ? null : TeamsClass.fromJson(json["teams"]),
        goals:
            json["goals"] == null ? null : TeamsClass.fromJson(json["goals"]),
        score: json["score"] == null ? null : Score.fromJson(json["score"]),
        events: json["events"] == null
            ? []
            : List<Event>.from(json["events"]!.map((x) => Event.fromJson(x))),
        lineups: json["lineups"] == null
            ? []
            : List<Lineup>.from(
                json["lineups"]!.map((x) => Lineup.fromJson(x))),
               statistics: json["statistics"] == null ? [] : List<Statistics>.from(json["statistics"]!.map((x) => Statistics.fromJson(x))),

        teamPlayers: json["players"] == null
            ? []
            : List<TeamPlayers>.from(
                json["players"]!.map((x) => TeamPlayers.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fixture": fixture?.toJson(),
        "league": league?.toJson(),
        "teams": teams?.toJson(),
        "goals": goals?.toJson(),
        "score": score?.toJson(),
        "events": events == null
            ? []
            : List<dynamic>.from(events!.map((x) => x.toJson())),
        "lineups": lineups == null
            ? []
            : List<dynamic>.from(lineups!.map((x) => x.toJson())),
        "statistics": statistics == null
            ? []
            : List<dynamic>.from(statistics!.map((x) => x.toJson())),
        "players": teamPlayers == null
            ? []
            : List<dynamic>.from(teamPlayers!.map((x) => x.toJson())),
      };
}

class Assist {
  int? id;
  String? name;

  Assist({
    this.id,
    this.name,
  });

  factory Assist.fromJson(Map<String, dynamic> json) => Assist(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class AwayClass {
  int? id;
  Name? name;
  String? logo;
  ShirtColor? colors;
  DateTime? update;
  bool? winner;

  AwayClass({
    this.id,
    this.name,
    this.logo,
    this.colors,
    this.update,
    this.winner,
  });

  factory AwayClass.fromJson(Map<String, dynamic> json) => AwayClass(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        logo: json["logo"],
        colors: json["colors"] == null ? null : ShirtColor.fromJson(json["colors"]),
        update: json["update"] == null ? null : DateTime.parse(json["update"]),
        winner: json["winner"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "logo": logo,
        "colors": colors?.toJson(),
        "update": update?.toIso8601String(),
        "winner": winner,
      };
}

class ShirtColor {
  Goalkeeper? player;
  Goalkeeper? goalkeeper;

  ShirtColor({
    this.player,
    this.goalkeeper,
  });

  factory ShirtColor.fromJson(Map<String, dynamic> json) => ShirtColor(
        player:
            json["player"] == null ? null : Goalkeeper.fromJson(json["player"]),
        goalkeeper: json["goalkeeper"] == null
            ? null
            : Goalkeeper.fromJson(json["goalkeeper"]),
      );

  Map<String, dynamic> toJson() => {
        "player": player?.toJson(),
        "goalkeeper": goalkeeper?.toJson(),
      };
}

class Goalkeeper {
  String? primary;
  String? number;
  String? border;

  Goalkeeper({
    this.primary,
    this.number,
    this.border,
  });

  factory Goalkeeper.fromJson(Map<String, dynamic> json) => Goalkeeper(
        primary: json["primary"],
        number: json["number"],
        border: json["border"],
      );

  Map<String, dynamic> toJson() => {
        "primary": primary,
        "number": number,
        "border": border,
      };
}

enum Name { DEPORTIVO_RIESTRA, TIGRE }

final nameValues = EnumValues(
    {"Deportivo Riestra": Name.DEPORTIVO_RIESTRA, "Tigre": Name.TIGRE});

class Time {
  int? elapsed;
  dynamic extra;

  Time({
    this.elapsed,
    this.extra,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        elapsed: json["elapsed"],
        extra: json["extra"],
      );

  Map<String, dynamic> toJson() => {
        "elapsed": elapsed,
        "extra": extra,
      };
}

enum Type { CARD, GOAL, SUBST }

final typeValues =
    EnumValues({"Card": Type.CARD, "Goal": Type.GOAL, "subst": Type.SUBST});

class TeamsClass {
  dynamic home;
  dynamic away;

  TeamsClass({
    this.home,
    this.away,
  });

  factory TeamsClass.fromJson(Map<String, dynamic> json) => TeamsClass(
        home: json["home"],
        away: json["away"],
      );

  Map<String, dynamic> toJson() => {
        "home": home,
        "away": away,
      };
}

class Coach {
  int? id;
  String? name;
  String? photo;

  Coach({
    this.id,
    this.name,
    this.photo,
  });

  factory Coach.fromJson(Map<String, dynamic> json) => Coach(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
      };
}

class StartXi {
  StartXiPlayer? player;

  StartXi({
    this.player,
  });

  factory StartXi.fromJson(Map<String, dynamic> json) => StartXi(
        player: json["player"] == null
            ? null
            : StartXiPlayer.fromJson(json["player"]),
      );

  Map<String, dynamic> toJson() => {
        "player": player?.toJson(),
      };
}

class StartXiPlayer {
  int? id;
  String? name;
  int? number;
  Pos? pos;
  String? grid;

  StartXiPlayer({
    this.id,
    this.name,
    this.number,
    this.pos,
    this.grid,
  });

  factory StartXiPlayer.fromJson(Map<String, dynamic> json) => StartXiPlayer(
        id: json["id"],
        name: json["name"],
        number: json["number"],
        pos: posValues.map[json["pos"]]!,
        grid: json["grid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "number": number,
        "pos": posValues.reverse[pos],
        "grid": grid,
      };
}

enum Pos { D, F, G, M }

final posValues = EnumValues({"D": Pos.D, "F": Pos.F, "G": Pos.G, "M": Pos.M});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
