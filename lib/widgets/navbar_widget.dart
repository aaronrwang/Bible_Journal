import 'package:flutter/material.dart';
import 'package:bible_journal/data/notifiers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: FaIcon(
                FontAwesomeIcons.handsPraying,
                size: 20,
              ),
              label: 'Prayer',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedIndex: selectedPage,
          onDestinationSelected: (int value) {
            selectedPageNotifier.value = value;
          },
        );
      },
    );
  }
}
