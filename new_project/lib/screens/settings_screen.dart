import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.translate('settings') ?? 'Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)?.translate('change_language') ?? 'Change Language'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(AppLocalizations.of(context)?.translate('select_language') ?? 'Select Language'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text('English'),
                        onTap: () {
                          // Implement language change to English
                        },
                      ),
                      ListTile(
                        title: Text('German'),
                        onTap: () {
                          // Implement language change to German
                        },
                      ),
                      ListTile(
                        title: Text('Russian'),
                        onTap: () {
                          // Implement language change to Russian
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context)?.translate('enable_notifications') ?? 'Enable Notifications'),
            value: true, // Implement logic for notifications here
            onChanged: (value) {
              // Handle notification toggle
            },
          ),
        ],
      ),
    );
  }
}
