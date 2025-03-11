class Journal {
  final int id;
  // final int userId;
  final String title;
  final DateTime createdAt;

  const Journal({
    required this.id,
    // required this.userId,
    required this.title,
    required this.createdAt,
  });

  factory Journal.fromJson(Map<String, dynamic> json) {
    return Journal(
      id: json['id'],
      title: json['Journal Name'],
      createdAt: DateTime.parse(json['created_at']).toLocal(),
    );
  }
}
