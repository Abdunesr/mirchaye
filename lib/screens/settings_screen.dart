import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDark = false;
  String selectedLanguage = 'Amharic';

  final languages = {
    'Amharic': '🇪🇹',
    'Oromo': '🌿',
    'Tigrinya': '🏔️',
    'Somali': '🐪',
    'Afar': '🔥',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          _buildBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '⚙️ Settings',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildGlassCard(
                    child: Row(
                      children: [
                        const Icon(Icons.dark_mode, color: Colors.white),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text('Dark Mode',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                        Switch.adaptive(
                          value: isDark,
                          onChanged: (val) {
                            setState(() => isDark = val);
                          },
                          activeColor: Colors.tealAccent,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildGlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('🌍 Language',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        const SizedBox(height: 10),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: Colors.black87,
                            value: selectedLanguage,
                            iconEnabledColor: Colors.white,
                            isExpanded: true,
                            style: const TextStyle(color: Colors.white),
                            items: languages.entries
                                .map((entry) => DropdownMenuItem(
                                      value: entry.key,
                                      child: Row(
                                        children: [
                                          Text(entry.value),
                                          const SizedBox(width: 10),
                                          Text(entry.key),
                                        ],
                                      ),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => selectedLanguage = val);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGlassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [Colors.black, Colors.grey[900]!]
              : [
                  Color.fromARGB(255, 45, 58, 68),
                  Color(0xFF203A43),
                  Color(0xFF2C5364),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
