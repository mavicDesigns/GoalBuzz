class Status {
  final String long;
  final String short;
  final int elapsed;

  Status({
    required this.long,
    required this.short,
    required this.elapsed,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      long: json['long'] ?? '',
      short: json['short'] ?? '',
      elapsed: json['elapsed'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'long': long,
        'short': short,
        'elapsed': elapsed,
      };
}
