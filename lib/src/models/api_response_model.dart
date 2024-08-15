
class FixtureResponse {
    String? apiResponseGet;
    Parameters? parameters;
    List<dynamic>? errors;
    int? results;
    Paging? paging;
    List<Data> data;

    FixtureResponse({
        required this.apiResponseGet,
        required this.parameters,
        required this.errors,
        required this.results,
        required this.paging,
        required this.data,
    });

    factory FixtureResponse.fromJson(Map<String, dynamic> json) => FixtureResponse(
     
        apiResponseGet: json["get"],
        parameters: Parameters.fromJson(json["parameters"]),
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
        results: json["results"],
        paging: Paging.fromJson(json["paging"]),
        data: List<Data>.from(json["response"].map((x) => Data.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "get": apiResponseGet,
        "parameters": parameters?.toJson(),
        "errors": errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
        "results": results,
        "paging": paging?.toJson(),
        "response": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Paging {
    int? current;
    int? total;

    Paging({
        this.current,
        this.total,
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
        fixture: json["fixture"] == null ? null : Fixture.fromJson(json["fixture"]),
        league: json["league"] == null ? null : League.fromJson(json["league"]),
        teams: json["teams"] == null ? null : TeamsClass.fromJson(json["teams"]),
        goals: json["goals"] == null ? null : TeamsClass.fromJson(json["goals"]),
        score: json["score"] == null ? null : Score.fromJson(json["score"]),
        events: json["events"] == null ? [] : List<Event>.from(json["events"]!.map((x) => Event.fromJson(x))),
        lineups: json["lineups"] == null ? [] : List<Lineup>.from(json["lineups"]!.map((x) => Lineup.fromJson(x))),
        statistics: json["statistics"] == null ? [] : List<Statistics>.from(json["statistics"]!.map((x) => Statistics.fromJson(x))),
        teamPlayers: json["players"] == null ? [] : List<TeamPlayers>.from(json["players"]!.map((x) => TeamPlayers.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "fixture": fixture?.toJson(),
        "league": league?.toJson(),
        "teams": teams?.toJson(),
        "goals": goals?.toJson(),
        "score": score?.toJson(),
        "events": events == null ? [] : List<dynamic>.from(events!.map((x) => x.toJson())),
        "lineups": lineups == null ? [] : List<dynamic>.from(lineups!.map((x) => x.toJson())),
        "statistics": statistics == null ? [] : List<dynamic>.from(statistics!.map((x) => x.toJson())),
        "players": teamPlayers == null ? [] : List<dynamic>.from(teamPlayers!.map((x) => x.toJson())),
    };
}

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
    String? name;
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
        name: json["name"],
        logo: json["logo"],
        colors: json["colors"] == null ? null : ShirtColor.fromJson(json["colors"]),
        update: json["update"] == null ? null : DateTime.parse(json["update"]),
        winner: json["winner"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
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
        player: json["player"] == null ? null : Goalkeeper.fromJson(json["player"]),
        goalkeeper: json["goalkeeper"] == null ? null : Goalkeeper.fromJson(json["goalkeeper"]),
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

class Time {
    int? elapsed;
    int? extra;

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

enum Type {
    CARD,
    GOAL,
    SUBST,
    VAR
}

final typeValues = EnumValues({
    "Card": Type.CARD,
    "Goal": Type.GOAL,
    "subst": Type.SUBST,
    "Var": Type.VAR
});

class Fixture {
    int? id;
    String? referee;
    String? timezone;
    DateTime? date;
    int? timestamp;
    Periods? periods;
    Venue? venue;
    Status? status;

    Fixture({
        this.id,
        this.referee,
        this.timezone,
        this.date,
        this.timestamp,
        this.periods,
        this.venue,
        this.status,
    });

    factory Fixture.fromJson(Map<String, dynamic> json) => Fixture(
        id: json["id"],
        referee: json["referee"],
        timezone: json["timezone"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        timestamp: json["timestamp"],
        periods: json["periods"] == null ? null : Periods.fromJson(json["periods"]),
        venue: json["venue"] == null ? null : Venue.fromJson(json["venue"]),
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "referee": referee,
        "timezone": timezone,
        "date": date?.toIso8601String(),
        "timestamp": timestamp,
        "periods": periods?.toJson(),
        "venue": venue?.toJson(),
        "status": status?.toJson(),
    };
}

class Periods {
    int? first;
    int? second;

    Periods({
        this.first,
        this.second,
    });

    factory Periods.fromJson(Map<String, dynamic> json) => Periods(
        first: json["first"],
        second: json["second"],
    );

    Map<String, dynamic> toJson() => {
        "first": first,
        "second": second,
    };
}

class Status {
    String? long;
    String? short;
    int? elapsed;

    Status({
        this.long,
        this.short,
        this.elapsed,
    });

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        long: json["long"],
        short: json["short"],
        elapsed: json["elapsed"],
    );

    Map<String, dynamic> toJson() => {
        "long": long,
        "short": short,
        "elapsed": elapsed,
    };
}

class Venue {
    int? id;
    String? name;
    String? city;

    Venue({
        this.id,
        this.name,
        this.city,
    });

    factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        id: json["id"],
        name: json["name"],
        city: json["city"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
    };
}

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

class League {
    int? id;
    String? name;
    String? country;
    String? logo;
    String? flag;
    int? season;
    String? round;

    League({
        this.id,
        this.name,
        this.country,
        this.logo,
        this.flag,
        this.season,
        this.round,
    });

    factory League.fromJson(Map<String, dynamic> json) => League(
        id: json["id"],
        name: json["name"],
        country: json["country"],
        logo: json["logo"],
        flag: json["flag"],
        season: json["season"],
        round: json["round"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country,
        "logo": logo,
        "flag": flag,
        "season": season,
        "round": round,
    };
}

class Lineup {
    AwayClass? team;
    Coach? coach;
    String? formation;
    List<StartXi>? startXi;
    List<StartXi>? substitutes;

    Lineup({
        this.team,
        this.coach,
        this.formation,
        this.startXi,
        this.substitutes,
    });

    factory Lineup.fromJson(Map<String, dynamic> json) => Lineup(
        team: json["team"] == null ? null : AwayClass.fromJson(json["team"]),
        coach: json["coach"] == null ? null : Coach.fromJson(json["coach"]),
        formation: json["formation"],
        startXi: json["startXI"] == null ? [] : List<StartXi>.from(json["startXI"]!.map((x) => StartXi.fromJson(x))),
        substitutes: json["substitutes"] == null ? [] : List<StartXi>.from(json["substitutes"]!.map((x) => StartXi.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "team": team?.toJson(),
        "coach": coach?.toJson(),
        "formation": formation,
        "startXI": startXi == null ? [] : List<dynamic>.from(startXi!.map((x) => x.toJson())),
        "substitutes": substitutes == null ? [] : List<dynamic>.from(substitutes!.map((x) => x.toJson())),
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
        player: json["player"] == null ? null : StartXiPlayer.fromJson(json["player"]),
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

enum Pos {
    D,
    F,
    G,
    M
}

final posValues = EnumValues({
    "D": Pos.D,
    "F": Pos.F,
    "G": Pos.G,
    "M": Pos.M
});

class TeamPlayers {
    AwayClass? team;
    List<MatchPlayers>? players;

    TeamPlayers({
        this.team,
        this.players,
    });

    factory TeamPlayers.fromJson(Map<String, dynamic> json) => TeamPlayers(
        team: json["team"] == null ? null : AwayClass.fromJson(json["team"]),
        players: json["players"] == null ? [] : List<MatchPlayers>.from(json["players"]!.map((x) => MatchPlayers.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "team": team?.toJson(),
        "players": players == null ? [] : List<dynamic>.from(players!.map((x) => x.toJson())),
    };
}

class MatchPlayers {
    Coach? player;
    List<PlayerStats>? statistics;

    MatchPlayers({
        this.player,
        this.statistics,
    });

    factory MatchPlayers.fromJson(Map<String, dynamic> json) => MatchPlayers(
        player: json["player"] == null ? null : Coach.fromJson(json["player"]),
        statistics: json["statistics"] == null ? [] : List<PlayerStats>.from(json["statistics"]!.map((x) => PlayerStats.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "player": player?.toJson(),
        "statistics": statistics == null ? [] : List<dynamic>.from(statistics!.map((x) => x.toJson())),
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

    factory PlayerStats.fromJson(Map<String, dynamic> json) => PlayerStats(
        games: json["games"] == null ? null : Games.fromJson(json["games"]),
        offsides: json["offsides"],
        shots: json["shots"] == null ? null : Shots.fromJson(json["shots"]),
        goals: json["goals"] == null ? null : StatisticGoals.fromJson(json["goals"]),
        passes: json["passes"] == null ? null : Passes.fromJson(json["passes"]),
        tackles: json["tackles"] == null ? null : Tackles.fromJson(json["tackles"]),
        duels: json["duels"] == null ? null : Duels.fromJson(json["duels"]),
        dribbles: json["dribbles"] == null ? null : Dribbles.fromJson(json["dribbles"]),
        fouls: json["fouls"] == null ? null : Fouls.fromJson(json["fouls"]),
        cards: json["cards"] == null ? null : Cards.fromJson(json["cards"]),
        penalty: json["penalty"] == null ? null : Penalty.fromJson(json["penalty"]),
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

class Statistics {
    AwayClass? team;
    List<StatisticStatistic>? statistics;

    Statistics({
        this.team,
        this.statistics,
    });

    factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        team: json["team"] == null ? null : AwayClass.fromJson(json["team"]),
        statistics: json["statistics"] == null ? [] : List<StatisticStatistic>.from(json["statistics"]!.map((x) => StatisticStatistic.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "team": team?.toJson(),
        "statistics": statistics == null ? [] : List<dynamic>.from(statistics!.map((x) => x.toJson())),
    };
}

class StatisticStatistic {
    String? type;
    dynamic value;

    StatisticStatistic({
        this.type,
        this.value,
    });

    factory StatisticStatistic.fromJson(Map<String, dynamic> json) => StatisticStatistic(
        type: json["type"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
