class SeatSession {
  final String sessionId;
  final DateTime expiresAt;
  final List<String> lockedSeats;

  SeatSession({
    required this.sessionId,
    required this.expiresAt,
    required this.lockedSeats,
  });

  factory SeatSession.fromJson(Map<String, dynamic> json) {
    return SeatSession(
      sessionId: json["sessionId"],
      expiresAt: DateTime.parse(json["sessionExpiresAt"]),
      lockedSeats: List<String>.from(json["lockedSeats"]),
    );
  }
}
