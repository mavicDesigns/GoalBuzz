
import 'package:truck/src/models/api_response_model.dart';

class TeamPlayers {
  AwayClass? team;
  List<MatchPlayers>? players;

  TeamPlayers({
    this.team,
    this.players,
  });

  factory TeamPlayers.fromJson(Map<String, dynamic> json) => TeamPlayers(
        team: json["team"] == null ? null : AwayClass.fromJson(json["team"]),
        players: json["players"] == null
            ? []
            : List<MatchPlayers>.from(
                json["players"]!.map((x) => MatchPlayers.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "team": team?.toJson(),
        "players": players == null
            ? []
            : List<dynamic>.from(players!.map((x) => x.toJson())),
      };
}


class Player {
  int? id;
  String? name;
  String? photo;

  Player({
    this.id,
    this.name,
    this.photo,
  });

  factory Player.fromJson(Map<String, dynamic> json) => Player(
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

class MatchPlayers {
  Player? player;
  List<PlayerStats>? statistics;

  MatchPlayers({
    this.player,
    this.statistics,
  });

  factory MatchPlayers.fromJson(Map<String, dynamic> json) => MatchPlayers(
        player: json["player"] == null ? null : Player.fromJson(json["player"]),
        statistics: json["statistics"] == null
            ? []
            : List<PlayerStats>.from(
                json["statistics"]!.map((x) => PlayerStats.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "player": player?.toJson(),
        "statistics": statistics == null
            ? []
            : List<dynamic>.from(statistics!.map((x) => x.toJson())),
      };
}

class PlayerStats {
  Games? games;
  int? offsides;
  Shots? shots;
  StatisticGoals? goals;
  Passes? passes;
  Tackles? tackles;
  Duels? duels;
  Dribbles? dribbles;
  Fouls? fouls;
  Cards? cards;
  Penalty? penalty;

  PlayerStats({
    this.games,
    this.offsides,
    this.shots,
    this.goals,
    this.passes,
    this.tackles,
    this.duels,
    this.dribbles,
    this.fouls,
    this.cards,
    this.penalty,
  });

  factory PlayerStats.fromJson(Map<String, dynamic> json) =>
      PlayerStats(
        games: json["games"] == null ? null : Games.fromJson(json["games"]),
        offsides: json["offsides"],
        shots: json["shots"] == null ? null : Shots.fromJson(json["shots"]),
        goals: json["goals"] == null
            ? null
            : StatisticGoals.fromJson(json["goals"]),
        passes: json["passes"] == null ? null : Passes.fromJson(json["passes"]),
        tackles:
            json["tackles"] == null ? null : Tackles.fromJson(json["tackles"]),
        duels: json["duels"] == null ? null : Duels.fromJson(json["duels"]),
        dribbles: json["dribbles"] == null
            ? null
            : Dribbles.fromJson(json["dribbles"]),
        fouls: json["fouls"] == null ? null : Fouls.fromJson(json["fouls"]),
        cards: json["cards"] == null ? null : Cards.fromJson(json["cards"]),
        penalty:
            json["penalty"] == null ? null : Penalty.fromJson(json["penalty"]),
      );

  Map<String, dynamic> toJson() => {
        "games": games?.toJson(),
        "offsides": offsides,
        "shots": shots?.toJson(),
        "goals": goals?.toJson(),
        "passes": passes?.toJson(),
        "tackles": tackles?.toJson(),
        "duels": duels?.toJson(),
        "dribbles": dribbles?.toJson(),
        "fouls": fouls?.toJson(),
        "cards": cards?.toJson(),
        "penalty": penalty?.toJson(),
      };
}

class Cards {
  int? yellow;
  int? red;

  Cards({
    this.yellow,
    this.red,
  });

  factory Cards.fromJson(Map<String, dynamic> json) => Cards(
        yellow: json["yellow"],
        red: json["red"],
      );

  Map<String, dynamic> toJson() => {
        "yellow": yellow,
        "red": red,
      };
}

class Dribbles {
  int? attempts;
  int? success;
  int? past;

  Dribbles({
    this.attempts,
    this.success,
    this.past,
  });

  factory Dribbles.fromJson(Map<String, dynamic> json) => Dribbles(
        attempts: json["attempts"],
        success: json["success"],
        past: json["past"],
      );

  Map<String, dynamic> toJson() => {
        "attempts": attempts,
        "success": success,
        "past": past,
      };
}

class Duels {
  int? total;
  int? won;

  Duels({
    this.total,
    this.won,
  });

  factory Duels.fromJson(Map<String, dynamic> json) => Duels(
        total: json["total"],
        won: json["won"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "won": won,
      };
}

class Fouls {
  int? drawn;
  int? committed;

  Fouls({
    this.drawn,
    this.committed,
  });

  factory Fouls.fromJson(Map<String, dynamic> json) => Fouls(
        drawn: json["drawn"],
        committed: json["committed"],
      );

  Map<String, dynamic> toJson() => {
        "drawn": drawn,
        "committed": committed,
      };
}

class Games {
  int? minutes;
  int? number;
  Pos? position;
  String? rating;
  bool? captain;
  bool? substitute;

  Games({
    this.minutes,
    this.number,
    this.position,
    this.rating,
    this.captain,
    this.substitute,
  });

  factory Games.fromJson(Map<String, dynamic> json) => Games(
        minutes: json["minutes"],
        number: json["number"],
        position: posValues.map[json["position"]]!,
        rating: json["rating"],
        captain: json["captain"],
        substitute: json["substitute"],
      );

  Map<String, dynamic> toJson() => {
        "minutes": minutes,
        "number": number,
        "position": posValues.reverse[position],
        "rating": rating,
        "captain": captain,
        "substitute": substitute,
      };
}

class StatisticGoals {
  int? total;
  int? conceded;
  int? assists;
  int? saves;

  StatisticGoals({
    this.total,
    this.conceded,
    this.assists,
    this.saves,
  });

  factory StatisticGoals.fromJson(Map<String, dynamic> json) => StatisticGoals(
        total: json["total"],
        conceded: json["conceded"],
        assists: json["assists"],
        saves: json["saves"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "conceded": conceded,
        "assists": assists,
        "saves": saves,
      };
}

class Passes {
  int? total;
  int? key;
  String? accuracy;

  Passes({
    this.total,
    this.key,
    this.accuracy,
  });

  factory Passes.fromJson(Map<String, dynamic> json) => Passes(
        total: json["total"],
        key: json["key"],
        accuracy: json["accuracy"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "key": key,
        "accuracy": accuracy,
      };
}

class Penalty {
  dynamic won;
  dynamic commited;
  int? scored;
  int? missed;
  int? saved;

  Penalty({
    this.won,
    this.commited,
    this.scored,
    this.missed,
    this.saved,
  });

  factory Penalty.fromJson(Map<String, dynamic> json) => Penalty(
        won: json["won"],
        commited: json["commited"],
        scored: json["scored"],
        missed: json["missed"],
        saved: json["saved"],
      );

  Map<String, dynamic> toJson() => {
        "won": won,
        "commited": commited,
        "scored": scored,
        "missed": missed,
        "saved": saved,
      };
}

class Shots {
  int? total;
  int? on;

  Shots({
    this.total,
    this.on,
  });

  factory Shots.fromJson(Map<String, dynamic> json) => Shots(
        total: json["total"],
        on: json["on"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "on": on,
      };
}

class Tackles {
  int? total;
  int? blocks;
  int? interceptions;

  Tackles({
    this.total,
    this.blocks,
    this.interceptions,
  });

  factory Tackles.fromJson(Map<String, dynamic> json) => Tackles(
        total: json["total"],
        blocks: json["blocks"],
        interceptions: json["interceptions"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "blocks": blocks,
        "interceptions": interceptions,
      };
}
