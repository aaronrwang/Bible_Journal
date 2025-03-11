import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

ValueNotifier journalEntryNotifier = ValueNotifier([]);

// Method to fetch prayer requests from Supabase
Future<void> fetchJournalEntries() async {
  final supabase = Supabase.instance.client;
  final response = await supabase.from('Journal Entries').select();

  List journalEntries = response
      .map((row) => {
            'id': row['id'].toString(),
            'notes': row['Entry']['Notes'],
            'title': row['Entry']['Title'],
            'date': DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(row['created_at']).toLocal()),
            'journalID': row['Journal_id'].toString(),
          })
      .toList();
  print("fetched journal entries");

  journalEntryNotifier.value = journalEntries; // Update the notifier
}
