import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Modern flexible app bar with parallax effect
          SliverAppBar(
            expandedHeight: 300,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.orange.shade900,
                      Colors.orange.shade700,
                      Colors.orange.shade600,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Futuristic background elements
                    Positioned(
                      right: -50,
                      top: 50,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange.shade800.withOpacity(0.2),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -30,
                      bottom: 80,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange.shade700.withOpacity(0.15),
                        ),
                      ),
                    ),
                    // Content
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Modern logo container with glassmorphism effect
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                'https://ewenet.net/wp-content/uploads/2023/03/new-logo-template-12.png',
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Text(
                            'EWENET COMMUNICATION',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Digital Transformation Architects',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Main content
          SliverToBoxAdapter(
            child: Column(
              children: [
                // About section with modern design
                _buildModernAboutSection(),

                // Services with horizontal scrolling cards
                _buildModernServicesSection(),

                // Values with animated cards
                _buildModernValuesSection(),

                // Contact CTA
                _buildModernContactSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernAboutSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'WHO WE ARE',
            style: TextStyle(
              color: Colors.orange.shade800,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Redefining Digital Experiences Since 2023',
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              height: 1.3,
            ),
          ),
          SizedBox(height: 25),
          Text(
            'Ewenet Communication stands at the forefront of digital innovation, crafting immersive software solutions that bridge the gap between technology and human experience. Our team of visionary developers, designers, and strategists collaborate to build platforms that don\'t just function—they inspire.',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16,
              height: 1.8,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 20),
          // Modern stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('50+', 'Projects'),
              _buildStatItem('100%', 'Client Satisfaction'),
              _buildStatItem('2023', 'Founded'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.orange.shade800,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _buildModernServicesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'OUR EXPERTISE',
              style: TextStyle(
                color: Colors.orange.shade800,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                letterSpacing: 2,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'Cutting-Edge Digital Solutions',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          SizedBox(height: 20),
          // Horizontal scrolling cards
          SizedBox(
            height: 280,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 25),
              children: [
                _buildModernServiceCard(
                  Icons.phone_iphone_rounded,
                  'Mobile Innovation',
                  'Next-gen apps with Flutter 4.0, AR integration, and AI capabilities',
                  Colors.orange.shade800,
                ),
                SizedBox(width: 20),
                _buildModernServiceCard(
                  Icons.language_rounded,
                  'Web Evolution',
                  'Progressive web apps with WebAssembly and 3D visualization',
                  Colors.orange.shade700,
                ),
                SizedBox(width: 20),
                _buildModernServiceCard(
                  Icons.design_services_rounded,
                  'Immersive Design',
                  'Neumorphic UI/UX with gesture-based navigation paradigms',
                  Colors.orange.shade600,
                ),
                SizedBox(width: 20),
                _buildModernServiceCard(
                  Icons.cloud_rounded,
                  'Cloud Native',
                  'Serverless architectures with quantum-ready encryption',
                  Colors.orange.shade500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernServiceCard(
      IconData icon, String title, String description, Color color) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
                height: 1.6,
                fontFamily: 'Poppins',
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.arrow_forward_rounded,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernValuesSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40),
      padding: EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
      ),
      child: Column(
        children: [
          Text(
            'OUR PHILOSOPHY',
            style: TextStyle(
              color: Colors.orange.shade800,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Core Principles That Drive Us',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                _buildModernValueCard(
                  '01',
                  'Future-First Thinking',
                  'We design for tomorrow, building adaptable systems ready for emerging technologies',
                ),
                _buildModernValueCard(
                  '02',
                  'Human-Centered AI',
                  'Our AI implementations enhance rather than replace human potential',
                ),
                _buildModernValueCard(
                  '03',
                  'Sustainable Code',
                  'Energy-efficient algorithms with minimal carbon footprint',
                ),
                _buildModernValueCard(
                  '04',
                  'Radical Transparency',
                  'Open communication with real-time project visibility',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernValueCard(
      String number, String title, String description) {
    return Container(
      width:
          MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width /
                  2 -
              40,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: TextStyle(
              color: Colors.orange.shade800,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              height: 0.9,
            ),
          ),
          SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
              height: 1.6,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernContactSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
      child: Column(
        children: [
          Text(
            'READY FOR DIGITAL TRANSFORMATION?',
            style: TextStyle(
              color: Colors.orange.shade800,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Let\'s Build The Future Together',
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 25),
          Text(
            'Our team is ready to bring your vision to life with cutting-edge technology and innovative thinking.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
              height: 1.8,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade800,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              shadowColor: Colors.orange.shade800.withOpacity(0.3),
            ),
            child: Text(
              'START YOUR PROJECT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          SizedBox(height: 40),
          Text(
            '© 2025 EWENET COMMUNICATION | All Rights Reserved',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
