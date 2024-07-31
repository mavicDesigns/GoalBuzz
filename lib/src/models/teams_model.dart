class Teams {
  final Team home;
  final Team away;

  Teams({
    required this.home,
    required this.away,
  });

  factory Teams.fromJson(Map<String, dynamic> json) {
    return Teams(
      home: Team.fromJson(json['home'] ?? {}),
      away: Team.fromJson(json['away'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'home': home.toJson(),
        'away': away.toJson(),
      };
}

class Team {
  final String id;
  final String name;
  final String logo;

  Team({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'logo': logo,
      };
}


