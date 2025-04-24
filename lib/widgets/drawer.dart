import 'package:flutter/material.dart';
import 'package:mirchaye/screens/home_screen.dart';
import 'package:mirchaye/screens/party_list_screen.dart';

class ModernElectionDrawer extends StatelessWidget {
  const ModernElectionDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Drawer(
      elevation: 16,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(24)),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    Colors.indigo.shade900,
                    Colors.deepPurple.shade900,
                  ]
                : [
                    Color.fromARGB(255, 45, 58, 68),
                    Color(0xFF203A43),
                    Color(0xFF2C5364),
                  ],
          ),
        ),
        child: Column(
          children: [
            // Header with NEBE logo
            Container(
              padding: const EdgeInsets.only(top: 48, bottom: 24),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: colorScheme.outlineVariant.withOpacity(0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.primary,
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.account_balance,
                      size: 40,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'NEBE Portal',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'National Election Board',
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),

            // Main Navigation Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 24),
                children: [
                  _ModernDrawerTile(
                    icon: Icons.home_filled,
                    title: 'Home',
                    isSelected: true,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                  ),
                  _ModernDrawerTile(
                    icon: Icons.groups,
                    title: 'Parties',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PartyListScreen(),
                        ),
                      );
                    },
                  ),
                  _ModernDrawerTile(
                    icon: Icons.account_balance,
                    title: 'NEBE',
                    onTap: () {},
                  ),
                  _ModernDrawerTile(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            // Footer
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Divider(color: colorScheme.outlineVariant.withOpacity(0.2)),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModernDrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModernDrawerTile({
    required this.icon,
    required this.title,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primary.withOpacity(0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isSelected
                ? colorScheme.primary
                : colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? colorScheme.primary
                : colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: isSelected
            ? colorScheme.primary.withOpacity(0.1)
            : Colors.transparent,
      ),
    );
  }
}
