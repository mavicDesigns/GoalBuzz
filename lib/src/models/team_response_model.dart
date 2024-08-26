// To parse this JSON data, do
//
//     final teamDetailsResponse = teamDetailsResponseFromJson(jsonString);

class TeamDetailsResponse {
  String teamDetailsResponseGet;
  Parameters parameters;
  List<dynamic> errors;
  int results;
  Paging paging;
  List<ResponseData> responseData;

  TeamDetailsResponse({
    required this.teamDetailsResponseGet,
    required this.parameters,
    required this.errors,
    required this.results,
    required this.paging,
    required this.responseData,
  });

  factory TeamDetailsResponse.fromJson(Map<String, dynamic> json) =>
      TeamDetailsResponse(
        teamDetailsResponseGet: json["get"],
        parameters: Parameters.fromJson(json["parameters"]),
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
        results: json["results"],
        paging: Paging.fromJson(json["paging"]),
        responseData: List<ResponseData>.from(
            json["response"].map((x) => ResponseData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "get": teamDetailsResponseGet,
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
  String id;

  Parameters({
    required this.id,
  });

  factory Parameters.fromJson(Map<String, dynamic> json) => Parameters(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class ResponseData {
  Team team;
  Venue venue;

  ResponseData({
    required this.team,
    required this.venue,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        team: Team.fromJson(json["team"]),
        venue: Venue.fromJson(json["venue"]),
      );

  Map<String, dynamic> toJson() => {
        "team": team.toJson(),
        "venue": venue.toJson(),
      };
}

class Team {
    int? id;
    String? name;
    String? code;
    String? country;
    int? founded;
    bool? national;
    String? logo;

    Team({
        this.id,
        this.name,
        this.code,
        this.country,
        this.founded,
        this.national,
        this.logo,
    });

    factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        country: json["country"],
        founded: json["founded"],
        national: json["national"],
        logo: json["logo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "country": country,
        "founded": founded,
        "national": national,
        "logo": logo,
    };
}

class Venue {
    int? id;
    String? name;
    String? address;
    String? city;
    int? capacity;
    String? surface;
    String? image;

    Venue({
        this.id,
        this.name,
        this.address,
        this.city,
        this.capacity,
        this.surface,
        this.image,
    });

    factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        capacity: json["capacity"],
        surface: json["surface"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "city": city,
        "capacity": capacity,
        "surface": surface,
        "image": image,
    };
}
