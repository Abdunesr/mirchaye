class News {
  final String id, title, body, imageUrl, date;
  final List<String> videoUrl;

  News({
    required this.id,
    required this.title,
    required this.body,
    required this.imageUrl,
    required this.videoUrl,
    required this.date,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        imageUrl: json['image_url'], // This one is correct in your JSON
        date: json['date'],
        videoUrl: List<String>.from(
            json['videoUrl'] ?? []), // Changed to match JSON key
      );
}
