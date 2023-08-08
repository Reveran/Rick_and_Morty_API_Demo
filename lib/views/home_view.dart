import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_demo/components/custom_list_tile.dart';
import 'package:rick_and_morty_demo/providers/navigation_provider.dart';
import 'package:rick_and_morty_demo/utils/app_routes_enum.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();

  final List<List> homeItems = const [
    [
      'assets/images/home_characters.jpg',
      Icons.groups,
      'Characters',
      'Get information about the characters we find in the show.',
      AppRoute.characters
    ],
    [
      'assets/images/home_locations.jpg',
      Icons.place,
      'Locations',
      'Get information about the places we see in the show.',
      AppRoute.locations
    ],
    [
      'assets/images/home_episodes.jpg',
      Icons.tv,
      'Episodes',
      'Get information about the episodes of the show.',
      AppRoute.episodes
    ],
  ];
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    NavigationProvider navProvider = Provider.of(context);
    ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome!,',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: theme.cardColor),
              textScaleFactor: 3,
            ),
            Text(
              'Select a category to start exploring.',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.cardColor,
                  height: 1),
              textScaleFactor: 2,
            ),
            const SizedBox(
              height: 8,
            ),
            ...widget.homeItems
                .map(
                  (item) => CustomListTile(
                    imageUrl: item[0],
                    icon: item[1],
                    title: item[2],
                    subtitle: item[3],
                    onTap: () {
                      navProvider.gotoRoute(item[4]);
                    },
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
