import 'package:bible_journal/data/providers/journal_provider.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class JournalEditor extends StatefulWidget {
  const JournalEditor({
    super.key,
  });

  @override
  State<JournalEditor> createState() => _JournalEditorState();
}

class _JournalEditorState extends State<JournalEditor> {
  final supabase = Supabase.instance.client; // Get Supabase instance
  TextEditingController title = TextEditingController();
  // TextEditingController description = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Journal Name',
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
              FilledButton(
                onPressed: () async {
                  String titleText = title.text.trim();
                  if (titleText.isNotEmpty) {
                    try {
                      final navigator = Navigator.of(context);
                      await supabase.from('Journals').insert({
                        'Journal Name':
                            titleText, // Ensure this matches your column name
                      });
                      print("Prayer Request Added: $titleText");
                      fetchJournals();
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
                child: Text('Create Journal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
