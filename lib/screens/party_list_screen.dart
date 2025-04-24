import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mirchaye/data/party_data.dart';
import 'package:mirchaye/model/party.dart';
import 'package:mirchaye/widgets/party_card.dart';

class PartyListScreen extends StatelessWidget {
  final List<Party> parties = partyData.map((e) => Party.fromJson(e)).toList();
  final String appBarImageUrl =
      'https://shabait.com/wp-content/uploads/2010/05/000000000000000000cabinetmay18.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 44, 57, 61),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Fancy App Bar with Image
          SliverAppBar(
            expandedHeight: 200,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: appBarImageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.orange[100],
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.orange[200],
                      child: const Icon(Icons.people,
                          color: Colors.white, size: 50),
                    ),
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.orange[800]!.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              title: const Text(
                "Political Parties",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black,
                      offset: Offset(1, 1),
                    )
                  ],
                ),
              ),
              centerTitle: true,
            ),
            backgroundColor: Colors.orange[800],
            elevation: 8,
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),

          // Party Grid
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return AnimatedPartyCard(party: parties[index]);
                },
                childCount: parties.length,
              ),
            ),
          ),
        ],
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.orange[700],
        child: const Icon(Icons.filter_list, color: Colors.white),
        elevation: 4,
      ),
    );
  }
}

class AnimatedPartyCard extends StatelessWidget {
  final Party party;

  const AnimatedPartyCard({required this.party});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + (100 * party.id.hashCode % 500)),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: PartyCard(
        party: party,
        width: 120,
        height: 180,
      ),
    );
  }
}
