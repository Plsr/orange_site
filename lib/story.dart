class Story {
  final String by;
  final int? descendants;
  final int id;
  final List? kids;
  final int score;
  final int time;
  final String title;
  final String type;
  final String url;

  Story({
    required this.by,
    required this.descendants,
    required this.id,
    required this.kids,
    required this.score,
    required this.time,
    required this.title,
    required this.type,
    required this.url,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      by: json['by'],
      descendants: json['descendants'],
      id: json['id'],
      kids: json['kids'] ?? [],
      score: json['score'],
      time: json['time'],
      title: json['title'],
      type: json['type'],
      url: json['url'],
    );
  }
}
