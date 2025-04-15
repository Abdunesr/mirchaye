import 'package:flutter/material.dart';
import 'package:mirchaye/model/party.dart';

class PartyDetailScreen extends StatelessWidget {
  final Party party;
  const PartyDetailScreen({required this.party});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(party.name)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Hero(
              tag: party.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(party.logoUrl, height: 150),
              ),
            ),
            SizedBox(height: 20),
            Text(
              party.leader,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              party.about,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text("Latest News",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ...party.news
                .map((n) => ListTile(
                      leading: Icon(Icons.campaign),
                      title: Text(n["title"]),
                      subtitle: Text(n["date"]),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
