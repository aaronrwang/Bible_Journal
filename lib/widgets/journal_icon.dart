import 'package:bible_journal/pages/journal_pages/journal_entry_editor.dart';
import 'package:bible_journal/pages/journal_pages/journal_viewer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class JournalIcon extends StatelessWidget {
  final String title;
  final String id;
  final String date;
  const JournalIcon({
    super.key,
    required this.title,
    required this.id,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  JournalViewer(journalID: id, journalName: title)),
        );
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), // Smaller radius
        ),
      ),
      child: Row(
        children: [
          FaIcon(FontAwesomeIcons.book, size: 50, color: Colors.teal),
          SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                  fontSize: 18.0,
                ),
              ),
              Text(date)
            ],
          ),
          Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: 0.0,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => JournalEntryEditor(journalID: id)),
              );
            },
            child: Icon(Icons.add, size: 30),
          ),
        ],
      ),
    );
  }
}
