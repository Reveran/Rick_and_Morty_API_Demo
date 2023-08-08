import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_demo/components/custom_navigation_bar.dart';
import 'package:rick_and_morty_demo/providers/navigation_provider.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({super.key});

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    NavigationProvider navProvider = Provider.of(context);
    ThemeData theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        if (navProvider.currentRoute == 0) {
          return true;
        }
        navProvider.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        body: SafeArea(
          child: navProvider.currentPage,
        ),
        bottomNavigationBar: const CustomNavigationBar(),
      ),
    );
  }
}
