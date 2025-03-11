import 'package:bible_journal/data/providers/journal_provider.dart';
import 'package:bible_journal/pages/journal_pages/journal_editor.dart';
import 'package:bible_journal/widgets/calendar_widget.dart';
import 'package:bible_journal/widgets/journal_icon.dart';
// import 'package:bible_journal/pages/journal_pages/journal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CalendarWidget(),
            Divider(),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text(
                  'New Journal',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                    fontSize: 18.0,
                  ),
                ),
                Spacer(),
                TextButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const JournalEditor()),
                    );
                  },
                  child: Icon(Icons.add, size: 30),
                ),
              ],
            ),
            ValueListenableBuilder(
              valueListenable:
                  journalNotifier, // Listens to changes in journalNotifier
              builder: (context, journals, _) {
                if (journals.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(),
                  ); // Show loading if empty
                }
                return Column(
                  children: List.generate(
                    journals.length,
                    (index) => JournalIcon(
                      title: journals[index]['name'],
                      id: journals[index]['id'],
                      date: journals[index]['date'],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
