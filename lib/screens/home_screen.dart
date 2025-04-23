import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mirchaye/data/news_data.dart';
import 'package:mirchaye/model/news.dart';
import 'package:mirchaye/screens/about_us_screen..dart';

import 'package:mirchaye/widgets/drawer.dart';
import 'package:mirchaye/widgets/news_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<News> newsList = newsData.map((e) => News.fromJson(e)).toList();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double _dragPosition = 0;
  bool _showDrawerHint = true;
  late PageController _pageController;
  int _currentAdIndex = 0;
  late Timer _adTimer;

  // Ad images for the flexible space
  final List<String> _adImages = [
    'https://tse4.mm.bing.net/th/id/OIP.QCy_Hu4jitgmTD3xM9h_KwHaFj?w=640&h=480&rs=1&pid=ImgDetMain',
    'https://th.bing.com/th/id/OIP.g1XbNYY1TXf9Q3VidFeO0wHaFA?w=209&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7',
    'https://th.bing.com/th/id/OIP.n7krWyXZGpVv1KsPrjhSkgHaEK?w=319&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1.0);
    _startAdCarousel();

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) setState(() => _showDrawerHint = false);
    });
  }

  void _startAdCarousel() {
    _adTimer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentAdIndex < _adImages.length - 1) {
        _currentAdIndex++;
      } else {
        _currentAdIndex = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentAdIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _adTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      drawer: const FancyDrawer(),
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
        onHorizontalDragEnd: (_) => setState(() => _dragPosition = 0),
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

            CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [StretchMode.fadeTitle],
                    background: Stack(
                      children: [
                        // Auto-scrolling ads
                        PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() => _currentAdIndex = index);
                          },
                          itemCount: _adImages.length,
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              imageUrl: _adImages[index],
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[300],
                                child: const Center(
                                    child: CircularProgressIndicator()),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.error_outline,
                                    color: Colors.red),
                              ),
                              fadeInDuration: const Duration(milliseconds: 500),
                            );
                          },
                        ),

                        // Gradient overlay
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
                      ],
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
                              builder: (context) => AboutAppPage()),
                        );
                      },
                    ),
                  ],
                ),

                // Ad indicator dots
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_adImages.length, (index) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentAdIndex == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                          ),
                        );
                      }),
                    ),
                  ),
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
                  duration: const Duration(milliseconds: 500),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.refresh, color: Colors.white),
        elevation: 4,
      ),
    );
  }
}
