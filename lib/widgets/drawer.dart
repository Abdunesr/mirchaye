import 'package:flutter/material.dart';

class ElectionDrawer extends StatelessWidget {
  const ElectionDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      elevation: 16,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(24)),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primaryContainer,
              colorScheme.secondaryContainer,
            ],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header
            DrawerHeader(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: colorScheme.outlineVariant.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: colorScheme.primary,
                    child:
                        const Icon(Icons.person, size: 32, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Election Portal',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    'v2.4.0',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),

            // Election Section
            _SectionHeader(
              icon: Icons.how_to_vote,
              title: 'Election',
              color: colorScheme.primary,
            ),
            _DrawerTile(
              icon: Icons.trending_up,
              title: 'Live Results',
              onTap: () {},
            ),
            _DrawerTile(
              icon: Icons.calendar_today,
              title: 'Schedule',
              onTap: () {},
            ),
            _DrawerTile(
              icon: Icons.location_on,
              title: 'Polling Stations',
              onTap: () {},
            ),

            // Parties Section
            _SectionHeader(
              icon: Icons.groups,
              title: 'Parties',
              color: Colors.blue,
            ),
            _DrawerTile(
              icon: Icons.flag,
              title: 'Registered Parties',
              onTap: () {},
            ),
            _DrawerTile(
              icon: Icons.assignment,
              title: 'Manifestos',
              onTap: () {},
            ),
            _DrawerTile(
              icon: Icons.leaderboard,
              title: 'Candidates',
              onTap: () {},
            ),

            // Settings Section
            _SectionHeader(
              icon: Icons.settings,
              title: 'Settings',
              color: Colors.grey,
            ),
            _DrawerTile(
              icon: Icons.notifications,
              title: 'Notifications',
              onTap: () {},
            ),
            _DrawerTile(
              icon: Icons.language,
              title: 'Language',
              onTap: () {},
            ),
            _DrawerTile(
              icon: Icons.dark_mode,
              title: 'Theme',
              onTap: () {},
            ),

            // Ads Section
            _SectionHeader(
              icon: Icons.campaign,
              title: 'Campaigns',
              color: Colors.orange,
            ),
            _DrawerTile(
              icon: Icons.ad_units,
              title: 'Political Ads',
              onTap: () {},
            ),
            _DrawerTile(
              icon: Icons.mic,
              title: 'Announcements',
              onTap: () {},
            ),

            // Aid Section
            _SectionHeader(
              icon: Icons.help_outline,
              title: 'Aid',
              color: Colors.green,
            ),
            _DrawerTile(
              icon: Icons.help,
              title: 'Voter Help',
              onTap: () {},
            ),
            _DrawerTile(
              icon: Icons.accessibility,
              title: 'Accessibility',
              onTap: () {},
            ),
            _DrawerTile(
              icon: Icons.contact_support,
              title: 'Contact EC',
              onTap: () {},
            ),

            const Divider(height: 32, thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Sign Out'),
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      visualDensity: const VisualDensity(vertical: -2),
    );
  }
}
