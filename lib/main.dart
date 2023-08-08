import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/custom_scaffold.dart';
import 'providers/characters_provider.dart';
import 'providers/episodes_provider.dart';
import 'providers/locations_provider.dart';
import 'providers/navigation_provider.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CharactersProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LocationsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EpisodesProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Rick and Morty Demo',
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        theme: AppTheme.light(),
        home: const CustomScaffold(),
      ),
    );
  }
}
