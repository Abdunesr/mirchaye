import 'package:flutter/material.dart';
import 'package:mirchaye/data/news_data.dart';
import 'package:mirchaye/model/news.dart';
import 'package:mirchaye/screens/about_us_screen..dart';
import 'package:mirchaye/widgets/drawer.dart';
import 'package:mirchaye/widgets/news_card.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<News> newsList = newsData.map((e) => News.fromJson(e)).toList();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double _dragPosition = 0;
  bool _showDrawerHint = true;

  @override
  void initState() {
    super.initState();
    // Hide drawer hint after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() => _showDrawerHint = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      drawer: FancyDrawer(), // Replace with your drawer widget
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            _dragPosition = details.primaryDelta!;
            if (_dragPosition > 20) {
              _showDrawerHint = false;
              _scaffoldKey.currentState!.openDrawer();
            }
          });
        },
        onHorizontalDragEnd: (_) {
          setState(() => _dragPosition = 0);
        },
        child: Stack(
          children: [
            // Background Gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0F2027),
                    Color(0xFF203A43),
                    Color(0xFF2C5364),
                  ],
                ),
              ),
            ),

            // Content
            CustomScrollView(
              slivers: [
                // AppBar with parallax effect
                SliverAppBar(
                  expandedHeight: 200,
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [StretchMode.fadeTitle],
                    background: CachedNetworkImage(
                      imageUrl:
                          'https://www.aljazeera.com/wp-content/uploads/2021/06/AP21172175474350.jpg?fit=1170%2C780',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: Icon(Icons.error_outline, color: Colors.red),
                      ),
                      fadeInDuration: const Duration(milliseconds: 500),
                      filterQuality: FilterQuality.high,
                    ),
                    title: const Text(
                      "Election News",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 10,
                            color: Colors.black,
                            offset: Offset(2, 2),
                          )
                        ],
                      ),
                    ),
                    centerTitle: true,
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  pinned: true,
                  leading: IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.group, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutUsPage()),
                        );
                      },
                    ),
                  ],
                ),

                // News List
                SliverPadding(
                  padding: const EdgeInsets.only(top: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: NewsCard(news: newsList[index]),
                        );
                      },
                      childCount: newsList.length,
                    ),
                  ),
                ),
              ],
            ),

            // Drawer Swipe Hint
            if (_showDrawerHint && _dragPosition.abs() < 10)
              Positioned(
                left: 10,
                top: MediaQuery.of(context).size.height / 2 - 25,
                child: AnimatedOpacity(
                  opacity: _showDrawerHint ? 1 : 0,
                  duration: const Duration(milliseconds: 50000),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.chevron_right, color: Colors.white),
                        const SizedBox(width: 4),
                        const Text(
                          "Swipe for menu",
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 4),
                        AnimatedBuilder(
                          animation:
                              AlwaysStoppedAnimation(_dragPosition / 100),
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(_dragPosition.clamp(-10, 10), 0),
                              child: child,
                            );
                          },
                          child: const Icon(Icons.chevron_right,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle refresh or other action
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.refresh, color: Colors.white),
        elevation: 4,
      ),
    );
  }
}
