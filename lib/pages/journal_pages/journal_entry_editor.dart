import 'package:bible_journal/data/providers/journal_entry_provider.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class JournalEntryEditor extends StatefulWidget {
  final String journalID;
  final String? entryID;
  const JournalEntryEditor({super.key, required this.journalID, this.entryID});

  @override
  State<JournalEntryEditor> createState() => _JournalEntryEditorState();
}

class _JournalEntryEditorState extends State<JournalEntryEditor> {
  final supabase = Supabase.instance.client; // Get Supabase instance
  TextEditingController title = TextEditingController();
  TextEditingController notes = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.entryID != null) {
      // Fetch data and populate the controllers
      loadEntryData(widget.entryID!);
    }
  }

  void loadEntryData(String entryId) async {
    // Simulate fetching from a database
    var entry = journalEntryNotifier.value
        .firstWhere((entry) => entry["id"] == widget.entryID);

    if (entry != null) {
      setState(() {
        title.text = entry['title'] ?? '';
        notes.text = entry['notes'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Entry Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: title,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onEditingComplete: () {
                  setState(() {});
                },
              ),
              SizedBox(height: 20.0),
              Text(
                'Notes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: notes,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Notes',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onEditingComplete: () {
                  setState(() {});
                },
              ),
              SizedBox(height: 20.0),
              FilledButton(
                onPressed: () async {
                  String titleText = title.text.trim();
                  String notesText = notes.text.trim();
                  if (titleText.isNotEmpty) {
                    try {
                      final navigator = Navigator.of(context);
                      if (widget.entryID == null) {
                        await supabase.from('Journal Entries').insert({
                          'Entry': {
                            'Title':
                                titleText, // Pack Title into JSON key "Title"
                            'Notes':
                                notesText, // Pack Notes into JSON key "Notes"
                          },
                          'Journal_id': int.parse(widget.journalID),
                        });
                      } else {
                        await supabase.from('Journal Entries').update({
                          'Entry': {
                            'Title':
                                titleText, // Update the Title inside the JSON key "Entry"
                            'Notes':
                                notesText, // Update the Notes inside the JSON key "Entry"
                          },
                          'Journal_id': int.parse(
                              widget.journalID), // Keep Journal ID if needed
                        }).eq(
                            'id',
                            widget
                                .entryID!); // Ensure we update the correct entry
                      }
                      print("Journal Entry Added: $titleText");
                      fetchJournalEntries();
                      navigator.pop();
                    } catch (e) {
                      print("Error inserting request: $e");
                    }
                  }
                },
                style: FilledButton.styleFrom(
                  minimumSize: Size(
                    100.0,
                    40.0,
                  ),
                ),
                child: (widget.entryID != null)
                    ? Text('Update Entry')
                    : Text('Create Entry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
