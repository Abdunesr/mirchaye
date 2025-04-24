import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class NebeScreen extends StatefulWidget {
  const NebeScreen({Key? key}) : super(key: key);

  @override
  State<NebeScreen> createState() => _NebeScreenState();
}

class _NebeScreenState extends State<NebeScreen> {
  final List<String> imageUrls = const [
    'https://th.bing.com/th/id/OIP.6hRQGurhN8w91C_-x54Q-gHaDm?w=287&h=170&c=7&r=0&o=5&dpr=1.5&pid=1.7',
    'https://tse3.mm.bing.net/th/id/OIP.0AaT8qbXVALlDUhEknnl8QAAAA?rs=1&pid=ImgDetMain',
    'https://th.bing.com/th/id/OIP.9YuX74OBHuefoHSPFkOt1AHaES?w=293&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7',
  ];

  final List<Map<String, String>> infoCards = const [
    {
      'title': 'Political Parties',
      'description':
          'Political Party means an association organized by citizens as a registered entity under Proclamation No. 1162/2011. It formulates programs to gain power nationally or regionally.',
      'linkText': 'Learn more about party registration',
      'linkUrl': 'https://nebe.org.et/political-parties',
      'icon': '🏛️',
    },
    {
      'title': 'Constituencies and Polling Stations',
      'description':
          'NEBE is authorized by Article 7 of Proclamation No. 11/33/2011 to establish constituencies and polling stations nationwide.',
      'linkText': 'See terms and conditions',
      'linkUrl': 'https://nebe.org.et/constituencies',
      'icon': '🗳️',
    },
    {
      'title': 'Electoral Laws',
      'description':
          'Established by the FDRE constitution, NEBE\'s establishment proclamation is No. 1133/2019.',
      'linkText': 'Read electoral laws',
      'linkUrl': 'https://nebe.org.et/electoral-laws',
      'icon': '⚖️',
    },
    {
      'title': 'How to vote?',
      'description':
          'Registered citizens vote at their designated polling station on election day.',
      'linkText': 'See voting process details',
      'linkUrl': 'https://nebe.org.et/voting-process',
      'icon': '✍️',
    },
    {
      'title': 'Electoral Cycle',
      'description':
          'An Election Cycle covers the pre-election period through to official result declarations.',
      'linkText': 'Learn about electoral cycle',
      'linkUrl': 'https://nebe.org.et/electoral-cycle',
      'icon': '🔄',
    },
    {
      'title': 'FAQ',
      'description': 'Common questions about NEBE\'s operations.',
      'linkText': 'View FAQs',
      'linkUrl': 'https://nebe.org.et/faq',
      'icon': '❓',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'National Election Board of Ethiopia',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
        centerTitle: true,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF203A43).withOpacity(0.9),
                    const Color(0xFF2C5364).withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 45, 58, 68),
              Color(0xFF203A43),
              Color(0xFF2C5364),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildImageGallery(context),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverMasonryGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childCount: infoCards.length,
                itemBuilder: (context, index) {
                  final card = infoCards[index];
                  return _buildInfoCard(
                    context,
                    title: card['title']!,
                    description: card['description']!,
                    linkText: card['linkText']!,
                    linkUrl: card['linkUrl']!,
                    icon: card['icon']!,
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageGallery(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: PageView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: imageUrls[index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[800]!,
                      highlightColor: Colors.grey[700]!,
                      child: Container(
                        color: Colors.grey[800],
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Text(
                      'NEBE Ethiopia',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: const Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required String description,
    required String linkText,
    required String linkUrl,
    required String icon,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 500),
        builder: (context, double value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, (1 - value) * 20),
              child: child,
            ),
          );
        },
        child: GestureDetector(
          onTap: () => _launchURL(linkUrl),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.white.withOpacity(0.1),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            icon,
                            style: const TextStyle(fontSize: 28),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                              height: 1.5,
                            ),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: () => _launchURL(linkUrl),
                        child: Row(
                          children: [
                            Text(
                              linkText,
                              style: const TextStyle(
                                color: Colors.lightBlueAccent,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.lightBlueAccent,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch $url'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
