// To parse this JSON data, do
//
//     final tableDetailsResponse = tableDetailsResponseFromJson(jsonString);

import 'dart:convert';

class StandingsResponse {
  String tableDetailsResponseGet;
  Parameters parameters;
  List<dynamic> errors;
  int results;
  Paging paging;
  List<ResponseData> responseData;

  StandingsResponse({
    required this.tableDetailsResponseGet,
    required this.parameters,
    required this.errors,
    required this.results,
    required this.paging,
    required this.responseData,
  });

  factory StandingsResponse.fromJson(Map<String, dynamic> json) =>
      StandingsResponse(
        tableDetailsResponseGet: json["get"],
        parameters: Parameters.fromJson(json["parameters"]),
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
        results: json["results"],
        paging: Paging.fromJson(json["paging"]),
        responseData: List<ResponseData>.from(
            json["response"].map((x) => ResponseData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "get": tableDetailsResponseGet,
        "parameters": parameters.toJson(),
        "errors": List<dynamic>.from(errors.map((x) => x)),
        "results": results,
        "paging": paging.toJson(),
        "response": List<dynamic>.from(responseData.map((x) => x.toJson())),
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
  String team;
  String season;

  Parameters({
    required this.team,
    required this.season,
  });

  factory Parameters.fromJson(Map<String, dynamic> json) => Parameters(
        team: json["team"],
        season: json["season"],
      );

  Map<String, dynamic> toJson() => {
        "team": team,
        "season": season,
      };
}

class ResponseData {
  League league;

  ResponseData({
    required this.league,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        league: League.fromJson(json["league"]),
      );

  Map<String, dynamic> toJson() => {
        "league": league.toJson(),
      };
}

class League {
  int? id;
  String? name;
  String? country;
  String? logo;
  String? flag;
  int? season;
  List<List<Standing>>? standings;

  League({
    this.id,
    this.name,
    this.country,
    this.logo,
    this.flag,
    this.season,
    this.standings,
  });

  factory League.fromJson(Map<String, dynamic> json) => League(
        id: json["id"],
        name: json["name"],
        country: json["country"],
        logo: json["logo"],
        flag: json["flag"],
        season: json["season"],
        standings: json["standings"] == null
            ? []
            : List<List<Standing>>.from(json["standings"]!.map((x) =>
                List<Standing>.from(x.map((x) => Standing.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
        "logo": logo,
        "flag": flag,
        "season": season,
        "standings": standings == null
            ? []
            : List<dynamic>.from(standings!
                .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class Standing {
  int? rank;
  Team? team;
  int? points;
  int? goalsDiff;
  String? group;
  String? form;
  String? status;
  String? description;
  All? all;
  All? home;
  All? away;
  DateTime? update;

  Standing({
    this.rank,
    this.team,
    this.points,
    this.goalsDiff,
    this.group,
    this.form,
    this.status,
    this.description,
    this.all,
    this.home,
    this.away,
    this.update,
  });

  factory Standing.fromJson(Map<String, dynamic> json) => Standing(
        rank: json["rank"],
        team: json["team"] == null ? null : Team.fromJson(json["team"]),
        points: json["points"],
        goalsDiff: json["goalsDiff"],
        group: json["group"],
        form: json["form"],
        status: json["status"],
        description: json["description"],
        all: json["all"] == null ? null : All.fromJson(json["all"]),
        home: json["home"] == null ? null : All.fromJson(json["home"]),
        away: json["away"] == null ? null : All.fromJson(json["away"]),
        update: json["update"] == null ? null : DateTime.parse(json["update"]),
      );

  Map<String, dynamic> toJson() => {
        "rank": rank,
        "team": team?.toJson(),
        "points": points,
        "goalsDiff": goalsDiff,
        "group": group,
        "form": form,
        "status": status,
        "description": description,
        "all": all?.toJson(),
        "home": home?.toJson(),
        "away": away?.toJson(),
        "update": update?.toIso8601String(),
      };
}

class All {
  int? played;
  int? win;
  int? draw;
  int? lose;
  Goals? goals;

  All({
    this.played,
    this.win,
    this.draw,
    this.lose,
    this.goals,
  });

  factory All.fromJson(Map<String, dynamic> json) => All(
        played: json["played"],
        win: json["win"],
        draw: json["draw"],
        lose: json["lose"],
        goals: json["goals"] == null ? null : Goals.fromJson(json["goals"]),
      );

  Map<String, dynamic> toJson() => {
        "played": played,
        "win": win,
        "draw": draw,
        "lose": lose,
        "goals": goals?.toJson(),
      };
}

class Goals {
  int? goalsFor;
  int? against;

  Goals({
    this.goalsFor,
    this.against,
  });

  factory Goals.fromJson(Map<String, dynamic> json) => Goals(
        goalsFor: json["for"],
        against: json["against"],
      );

  Map<String, dynamic> toJson() => {
        "for": goalsFor,
        "against": against,
      };
}

class Team {
  int? id;
  String? name;
  String? logo;

  Team({
    this.id,
    this.name,
    this.logo,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
      };
}
