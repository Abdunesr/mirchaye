import 'package:flutter/material.dart';
import 'package:mirchaye/widgets/drawer.dart';
import 'screens/home_screen.dart';
import 'screens/party_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: MainTabs(),
    );
  }
}

class MainTabs extends StatefulWidget {
  @override
  _MainTabsState createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _indicatorPosition = 0.0;

  final List<Widget> _screens = [
    HomeScreen(),
    PartyListScreen(),
    PartyListScreen(), // Placeholder for 3rd tab
    PartyListScreen(), // Placeholder for 4th tab
  ];

  // Updated color scheme
  final List<BottomNavigationItem> _navItems = [
    BottomNavigationItem(
        Icons.newspaper, "News", Color.fromARGB(170, 241, 157, 55)), // Purple
    BottomNavigationItem(
        Icons.groups, "Parties", Color.fromARGB(170, 241, 157, 55)), // Teal
    BottomNavigationItem(
        Icons.analytics, "Stats", Color.fromARGB(170, 241, 157, 55)), // Blue
    BottomNavigationItem(
        Icons.person, "Profile", Color.fromARGB(170, 241, 157, 55)), // Pink
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    final double newPosition = index.toDouble();
    setState(() {
      _currentIndex = index;
      _animationController.reset();
      _animationController.forward();
    });

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _indicatorPosition = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final itemWidth = width / _navItems.length;

    return Scaffold(
      drawer: const FancyDrawer(),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        height: 90,
        child: Stack(
          children: [
            // Dark background with subtle gradient
            Positioned.fill(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOutExpo,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF2D3436),
                      Color(0xFF1E272E),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
              ),
            ),

            // Glowing effect under active tab
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipPath(
                clipper: BottomNavigationClipper(
                    indicatorPosition: _indicatorPosition,
                    itemCount: _navItems.length),
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        _navItems[_currentIndex].color.withOpacity(0.4),
                        _navItems[_currentIndex].color.withOpacity(0.1),
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.5, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),

            // Content
            Column(
              children: [
                // Animated glowing indicator
                AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeOutExpo,
                  margin: EdgeInsets.only(
                    left: _indicatorPosition * itemWidth + itemWidth * 0.2,
                    right: (itemWidth * 0.6) / 2,
                  ),
                  width: itemWidth * 0.6,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _navItems[_currentIndex].color,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: _navItems[_currentIndex].color.withOpacity(0.7),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: Row(
                    children: _navItems.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      final isSelected = index == _currentIndex;

                      return Expanded(
                        child: GestureDetector(
                          onTap: () => _onTabTapped(index),
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Animated icon with floating effect
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  transform: Matrix4.identity()
                                    ..translate(
                                      0.0,
                                      isSelected ? -10.0 : 0.0,
                                      0.0,
                                    ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      if (isSelected)
                                        AnimatedContainer(
                                          duration: Duration(milliseconds: 300),
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: item.color.withOpacity(0.2),
                                          ),
                                        ),
                                      Icon(
                                        item.icon,
                                        color: isSelected
                                            ? item.color
                                            : Colors.grey.withOpacity(0.7),
                                        size: isSelected ? 26 : 24,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                // Animated text with glow effect
                                AnimatedDefaultTextStyle(
                                  duration: Duration(milliseconds: 300),
                                  style: TextStyle(
                                    color: isSelected
                                        ? item.color
                                        : Colors.grey.withOpacity(0.7),
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: isSelected ? 13 : 12,
                                    shadows: isSelected
                                        ? [
                                            Shadow(
                                              color:
                                                  item.color.withOpacity(0.5),
                                              blurRadius: 5,
                                              offset: Offset(0, 0),
                                            )
                                          ]
                                        : [],
                                  ),
                                  child: Text(item.label),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavigationItem {
  final IconData icon;
  final String label;
  final Color color;

  BottomNavigationItem(this.icon, this.label, this.color);
}

class BottomNavigationClipper extends CustomClipper<Path> {
  final double indicatorPosition;
  final int itemCount;

  BottomNavigationClipper(
      {required this.indicatorPosition, required this.itemCount});

  @override
  Path getClip(Size size) {
    final path = Path();
    final itemWidth = size.width / itemCount;
    final centerX = indicatorPosition * itemWidth + itemWidth / 2;

    path.moveTo(0, size.height);
    path.lineTo(0, 10);

    // Draw a smoother wave curve
    path.cubicTo(
      centerX - itemWidth,
      10,
      centerX - itemWidth * 0.7,
      -5,
      centerX - itemWidth * 0.3,
      5,
    );
    path.cubicTo(
      centerX,
      15,
      centerX + itemWidth * 0.3,
      5,
      centerX + itemWidth * 0.7,
      -5,
    );
    path.cubicTo(
      centerX + itemWidth,
      10,
      size.width,
      10,
      size.width,
      size.height,
    );

    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
