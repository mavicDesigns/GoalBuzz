
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