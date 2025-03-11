import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

ValueNotifier prayerRequestsNotifier = ValueNotifier([]);

// Method to fetch prayer requests from Supabase
Future<void> fetchPrayerRequests() async {
  final supabase = Supabase.instance.client;

  // Fetch prayer requests from the 'Prayer Requests' table
  final response = await supabase
      .from('Prayer Requests')
      .select(); // Replace with your actual table name // Assuming 'request' is a column in the table

  List requests = List.from(response.map((row) => {
        'request': row['request'].toString(),
        'id': row['id'],
      }));

  print("fetched prayer requests");

  prayerRequestsNotifier.value = requests; // Update the notifier
}
