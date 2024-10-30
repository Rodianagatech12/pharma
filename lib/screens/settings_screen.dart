import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pharma/providers/dark_mode_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkModeProvider = Provider.of<DarkModeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: darkModeProvider.isDarkMode
            ? Colors.grey[850]
            : const Color(0xFF4FC3F7),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: darkModeProvider.isDarkMode,
                onChanged: (value) {
                  darkModeProvider.toggleDarkMode();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
