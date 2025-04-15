import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class FancyDrawer extends StatefulWidget {
  const FancyDrawer({Key? key}) : super(key: key);

  @override
  _FancyDrawerState createState() => _FancyDrawerState();
}

class _FancyDrawerState extends State<FancyDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutQuint,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 197, 90, 2),
              Color.fromARGB(255, 234, 184, 78),
              Color.fromARGB(255, 149, 71, 7),
            ],
          ),
        ),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                // Header with image
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://th.bing.com/th/id/R.1a8508f6149848e61ee9a7aa7b0478b1?rik=Heauht2m2dW1Hg&pid=ImgRaw&r=0',
                      ),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Election App',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Make your vote count!',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Menu items
                Expanded(
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        _buildMenuItem(
                          icon: Icons.home,
                          title: 'Home',
                          onTap: () => _navigateTo('/home'),
                        ),
                        _buildMenuItem(
                          icon: Icons.how_to_vote,
                          title: 'Vote Now',
                          onTap: () => _navigateTo('/vote'),
                        ),
                        _buildMenuItem(
                          icon: Icons.people,
                          title: 'Candidates',
                          onTap: () => _navigateTo('/candidates'),
                        ),
                        _buildMenuItem(
                          icon: Icons.bar_chart,
                          title: 'Polls',
                          onTap: () => _navigateTo('/polls'),
                        ),
                        _buildMenuItem(
                          icon: Icons.info,
                          title: 'About Election',
                          onTap: () => _navigateTo('/about'),
                        ),
                        const Divider(
                          color: Colors.white24,
                          height: 30,
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                        ),
                        _buildMenuItem(
                          icon: Icons.settings,
                          title: 'Settings',
                          onTap: () => _navigateTo('/settings'),
                        ),
                        _buildMenuItem(
                          icon: Icons.help,
                          title: 'Help & Feedback',
                          onTap: () => _navigateTo('/help'),
                        ),
                      ],
                    ),
                  ),
                ),

                // Footer
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Powered by Democracy',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.facebook,
                                color: Colors.white54),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(FontAwesome.twitter,
                                color: Colors.white54),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(FontAwesome.instagram,
                                color: Colors.white54),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white.withOpacity(0.8),
        size: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Montserrat',
        ),
      ),
      onTap: () {
        _animationController.reverse().then((_) {
          onTap();
        });
      },
      hoverColor: Colors.white.withOpacity(0.1),
      focusColor: Colors.white.withOpacity(0.05),
    );
  }

  void _navigateTo(String route) {
    Navigator.of(context).pushNamed(route);
  }
}
