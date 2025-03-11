import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

ValueNotifier journalNotifier = ValueNotifier([]);

// Method to fetch prayer requests from Supabase
Future<void> fetchJournals() async {
  final supabase = Supabase.instance.client;
  final response = await supabase.from('Journals').select();

  List journals = response
      .map((row) => {
            'id': row['id'].toString(),
            'name': row['Journal Name'].toString(),
            'date': DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(row['created_at']).toLocal()),
          })
      .toList();
  print("fetched journals");

  journalNotifier.value = journals; // Update the notifier
}
