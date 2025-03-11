import 'package:bible_journal/data/providers/journal_entry_provider.dart';
import 'package:bible_journal/data/providers/journal_provider.dart';
import 'package:bible_journal/pages/home_page.dart';
import 'package:bible_journal/pages/prayer_page.dart';
import 'package:bible_journal/pages/profile_page.dart';
import 'package:bible_journal/widgets/navbar_widget.dart';
import 'package:bible_journal/data/notifiers.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bible_journal/data/providers/prayer_requests_provider.dart';

List<Widget> pages = [
  HomePage(),
  PrayerPage(),
  ProfilePage(),
];

void _showAddPrayerDialog(BuildContext context) {
  TextEditingController prController = TextEditingController();
  final supabase = Supabase.instance.client; // Get Supabase instance

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Add Prayer Request"),
        content: TextField(
          controller: prController,
          decoration: InputDecoration(hintText: "Enter your prayer request"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Close dialog
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              String requestText = prController.text.trim();
              if (requestText.isNotEmpty) {
                try {
                  await supabase.from('Prayer Requests').insert({
                    'request':
                        requestText, // Ensure this matches your column name
                  });
                  print("Prayer Request Added: $requestText");
                } catch (e) {
                  print("Error inserting request: $e");
                }
              }
              fetchPrayerRequests();
              Navigator.of(context).pop(); // Close dialog
            },
            child: Text("Add"),
          ),
        ],
      );
    },
  );
}

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  initState() {
    selectedPageNotifier.value = 0;
    fetchPrayerRequests();
    fetchJournals();
    fetchJournalEntries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ValueListenableBuilder<int>(
        valueListenable: selectedPageNotifier,
        builder: (context, value, child) {
          return value == 1
              ? FloatingActionButton(
                  onPressed: () => _showAddPrayerDialog(context),
                  child: Icon(Icons.add),
                )
              : SizedBox.shrink();
        },
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: selectedPageNotifier,
            builder: (context, value, child) {
              return pages.elementAt(value);
            }),
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
