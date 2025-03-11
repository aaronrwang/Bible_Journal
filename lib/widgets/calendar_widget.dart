import 'package:bible_journal/data/providers/journal_entry_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  List<String> getThisWeekDates() {
    // Get today's date
    DateTime today = DateTime.now();

    // Calculate the start of the week (Monday)
    DateTime startOfWeek = today.subtract(Duration(days: today.weekday % 7));

    // Generate a list of dates for the current week (Monday to Sunday)
    List<String> weekDates = List.generate(7, (index) {
      DateTime date = startOfWeek.add(Duration(days: index));
      return DateFormat('yyyy-MM-dd').format(date); // Format as 'YYYY-MM-DD'
    });

    return weekDates;
  }

  List<String> dates = [];
  List<String> days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  initState() {
    dates = getThisWeekDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            journalEntryNotifier, // Listens to changes in journalNotifier
        builder: (context, journalEntries, _) {
          Set activeDates =
              journalEntryNotifier.value.map((entry) => entry['date']).toSet();
          print(activeDates);
          print(dates);
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(dates.length, (index) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(days[index]),
                    Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: (activeDates.contains(dates[index]))
                            ? Colors.teal
                            : null,
                        border: Border.all(
                          color: Colors.teal, // Set border color to blue
                          width: 2.0, // Set border width
                        ),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Center(
                          child: Text(
                              dates[index].substring(dates[index].length - 2))),
                    ),
                  ],
                ),
              );
            }),
          );
        });
  }
}
