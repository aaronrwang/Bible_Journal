import 'package:bible_journal/pages/journal_pages/journal_entry_editor.dart';
import "package:flutter/material.dart";
import 'package:bible_journal/data/providers/journal_entry_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class JournalEntryViewer extends StatefulWidget {
  final String entryID;
  const JournalEntryViewer({super.key, required this.entryID});

  @override
  State<JournalEntryViewer> createState() => JournalEntryViewerState();
}

class JournalEntryViewerState extends State<JournalEntryViewer> {
  bool _isExpanded = false;

  void _toggleMenu() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this entry?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close modal
              },
              child: Text("No"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                await _deleteEntry(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _deleteEntry(BuildContext context) async {
    final supabase = Supabase.instance.client;
    try {
      await supabase
          .from('Journal Entries')
          .delete()
          .eq('id', int.parse(widget.entryID));
      fetchJournalEntries();
      print("Entry deleted successfully!");
      return true;
    } catch (error) {
      print("Failed to delete entry: $error");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          journalEntryNotifier, // Listens to changes in journalNotifier
      builder: (context, journalEntries, _) {
        if (journalEntries.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final entry =
            journalEntries.firstWhere((entry) => entry["id"] == widget.entryID);
        if (entry == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(title: Text(entry['title'])),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(entry['notes']),
            ),
          ),
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isExpanded) ...[
                FloatingActionButton(
                  heroTag: "btn1",
                  mini: true,
                  onPressed: () => {_showDeleteConfirmation(context)},
                  child: Icon(Icons.delete),
                ),
                SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: "btn2",
                  mini: true,
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JournalEntryEditor(
                          journalID: entry['journalID'],
                          entryID: widget.entryID,
                        ),
                      ),
                    )
                  },
                  child: Icon(Icons.edit_document),
                ),
                SizedBox(height: 10),
              ],
              FloatingActionButton(
                heroTag: "main",
                onPressed: _toggleMenu,
                child: Icon(_isExpanded ? Icons.close : Icons.more_horiz),
              ),
            ],
          ),
        );
      },
    );
  }
}
