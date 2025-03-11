import 'package:bible_journal/data/providers/journal_entry_provider.dart';
import 'package:bible_journal/data/providers/journal_provider.dart';
import 'package:bible_journal/data/providers/prayer_requests_provider.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  final String username = 'Aaron';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
            Text('Username: ${username}'),
            SizedBox(height: 10.0),
            Divider(height: 1.0, thickness: 2.0),
            SizedBox(height: 5.0),
            Option(
              label: 'Refresh Journals',
              icon: Icon(Icons.refresh),
              onPressed: fetchJournals,
            ),
            Option(
              label: 'Refresh Journals Entries',
              icon: Icon(Icons.refresh),
              onPressed: fetchJournalEntries,
            ),
            Option(
              label: 'Refresh Prayer Requests',
              icon: Icon(Icons.refresh),
              onPressed: fetchPrayerRequests,
            ),
            Option(
              label: 'Refresh all',
              icon: Icon(Icons.refresh),
              onPressed: () {
                fetchJournalEntries();
                fetchJournals();
                fetchPrayerRequests();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Option extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Icon icon;

  const Option(
      {Key? key,
      required this.label,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        onPressed: onPressed,
        child: Align(
          alignment: Alignment.centerLeft, // Aligns the Row to the left
          child: Row(
            children: [
              icon, // Logout icon
              SizedBox(width: 8), // Space between icon and text
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}
