import 'package:bible_journal/pages/journal_pages/journal_entry_viewer.dart';
import "package:flutter/material.dart";
import 'package:bible_journal/data/providers/journal_entry_provider.dart';

class JournalViewer extends StatefulWidget {
  final String journalID;
  final String journalName;
  const JournalViewer(
      {super.key, required this.journalID, required this.journalName});

  @override
  State<JournalViewer> createState() => JournalViewerState();
}

class JournalViewerState extends State<JournalViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.journalName)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ValueListenableBuilder(
            valueListenable:
                journalEntryNotifier, // Listens to changes in journalNotifier
            builder: (context, journalEntries, _) {
              if (journalEntries.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                ); // Show loading if empty
              }
              var filteredEntries = journalEntries
                  .where((entry) => entry['journalID'] == widget.journalID)
                  .toList();
              if (filteredEntries.isEmpty) {
                return Center(
                    child: Text('No Entries')); // Show loading if empty
              }
              return Column(
                children: List.generate(
                  filteredEntries.length,
                  (index) => Column(
                    children: [
                      Divider(),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JournalEntryViewer(
                                      entryID: filteredEntries[index]['id'],
                                    )),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(4), // Smaller radius
                          ),
                        ),
                        child: SizedBox(
                          width: double
                              .infinity, // This makes the button take up full width
                          child: Text(
                            filteredEntries[index]['title'],
                            textAlign: TextAlign
                                .center, // Optional: centers the text inside the button
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
