

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
