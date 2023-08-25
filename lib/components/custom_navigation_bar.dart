import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_demo/providers/navigation_provider.dart';
import 'package:rick_and_morty_demo/utils/app_routes_enum.dart';

/// A customized Gnav bar to fit the app style.
class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({
    super.key,
  });

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final List<List> menuItems = const [
    [Icons.home, 'Home', AppRoute.home],
    [Icons.groups, 'Characters', AppRoute.characters],
    [Icons.place, 'Locations', AppRoute.locations],
    [Icons.tv, 'Episodes', AppRoute.episodes],
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    NavigationProvider navProvider = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: GNav(
        gap: 8,
        selectedIndex: navProvider.currentRoute,
        color: theme.colorScheme.tertiary,
        tabBackgroundColor: theme.colorScheme.secondary,
        activeColor: theme.cardColor,
        padding: const EdgeInsets.all(8),
        tabs: menuItems
            .map((item) => GButton(
                  icon: item[0],
                  text: item[1],
                  onPressed: () {
                    navProvider.gotoRoute(item[2]);
                  },
                ))
            .toList(),
      ),
    );
  }
}
