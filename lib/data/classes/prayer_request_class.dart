class PrayerRequest {
  final String id;
  final String request;
  final DateTime createdAt;

  PrayerRequest(
      {required this.id, required this.request, required this.createdAt});

  // A factory method to convert the database response to a PrayerRequest object
  factory PrayerRequest.fromJson(Map<String, dynamic> json) {
    return PrayerRequest(
      id: json['id'],
      request: json['request'],
      createdAt: DateTime.parse(json['created_at']).toLocal(),
    );
  }
}
