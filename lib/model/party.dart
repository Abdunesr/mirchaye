class Party {
  final String id, name, logoUrl, leader, about;
  final bool isRulingParty;
  final List<Map<String, dynamic>> news;

  Party({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.leader,
    required this.about,
    required this.news,
    required this.isRulingParty,
  });

  factory Party.fromJson(Map<String, dynamic> json) => Party(
        id: json['id'],
        name: json['name'],
        logoUrl: json['logo_url'],
        leader: json['leader'],
        about: json['about'],
        isRulingParty: json['isRulingParty'] ?? false,
        news: List<Map<String, dynamic>>.from(json['news']),
      );
}
