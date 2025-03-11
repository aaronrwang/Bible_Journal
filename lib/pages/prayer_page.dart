import 'package:flutter/material.dart';
import 'package:bible_journal/data/providers/prayer_requests_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PrayerPage extends StatefulWidget {
  const PrayerPage({super.key});

  @override
  State<PrayerPage> createState() => _PrayerPageState();
}

class _PrayerPageState extends State<PrayerPage> {
  num index = 0;
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          prayerRequestsNotifier, // Listens to changes in journalNotifier
      builder: (context, prayerRequests, _) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: GestureDetector(
                onTap: () {
                  if (prayerRequests.isNotEmpty) {
                    setState(() {
                      index = (index + 1) % prayerRequests.length;
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    color: Color(0xFF333333),
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(3, 12),
                        blurRadius: 8.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child:
                        // child: Stack(
                        //   children: [
                        Center(
                      // Center the text content within the Stack
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        child: Text(
                          prayerRequests.isNotEmpty
                              ? prayerRequests[index]['request']
                              : "Loading...",
                          key: ValueKey<num>(index),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                    //     Positioned(
                    //       top: 10,
                    //       right: 10,
                    //       child: IconButton(
                    //         icon: Icon(
                    //           Icons.delete,
                    //           color: Colors.white,
                    //           size: 24,
                    //         ),
                    //         onPressed: () async {
                    //           try {
                    //             await supabase
                    //                 .from('Prayer Requests')
                    //                 .delete()
                    //                 .eq('id', prayerRequests[index]['id']);
                    //             fetchPrayerRequests();
                    //             print("Entry deleted successfully!");
                    //           } catch (error) {
                    //             print("Failed to delete entry: $error");
                    //           }
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                )),
          ),
        );
      },
    );
  }
}
