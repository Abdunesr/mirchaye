class News {
  final String id, title, body, imageUrl, date;
  News(
      {required this.id,
      required this.title,
      required this.body,
      required this.imageUrl,
      required this.date});
  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        imageUrl: json['image_url'],
        date: json['date'],
      );
}
