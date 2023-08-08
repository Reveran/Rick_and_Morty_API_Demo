import 'package:flutter/material.dart';
import 'package:rick_and_morty_demo/utils/app_routes_enum.dart';
import 'package:rick_and_morty_demo/views/characters_view.dart';
import 'package:rick_and_morty_demo/views/detailed_character_view.dart';
import 'package:rick_and_morty_demo/views/detailed_location_view.dart';
import 'package:rick_and_morty_demo/views/episodes_view.dart';
import 'package:rick_and_morty_demo/views/error_view.dart';
import 'package:rick_and_morty_demo/views/home_view.dart';
import 'package:rick_and_morty_demo/views/locations_view.dart';

import '../views/detailed_episode_view.dart';

class NavigationProvider with ChangeNotifier {
  int _currentRoute = 0;
  List<AppRoute> _routeStack = [AppRoute.home];
  Widget _currentPage = const HomeView();

  Widget get currentPage => _currentPage;
  int get currentRoute => _currentRoute;

  void gotoRoute(AppRoute route, {String args = '', bool isPoping = false}) {
    if (!isPoping && route == _routeStack.last) {
      return;
    }

    switch (route) {
      case AppRoute.home:
        _currentRoute = 0;
        _routeStack = [AppRoute.home];
        _currentPage = const HomeView();
        break;
      case AppRoute.characters:
        _currentRoute = 1;
        _routeStack.add(route);
        _currentPage = const CharactersView();
        break;
      case AppRoute.detailedCharacter:
        if (args.isNotEmpty || isPoping) {
          _currentRoute = 1;
          _routeStack.add(route);
          _currentPage = DetailedCharacterView(characterId: args);
        }
        break;
      case AppRoute.locations:
        _currentRoute = 2;
        _routeStack.add(route);
        _currentPage = const LocationsView();
        break;
      case AppRoute.detailedLocation:
        if (args.isNotEmpty || isPoping) {
          _currentRoute = 2;
          _routeStack.add(route);
          _currentPage = DetailedLocationView(locationId: args);
        }
        break;
      case AppRoute.episodes:
        _currentRoute = 3;
        _routeStack.add(route);
        _currentPage = const EpisodesView();
        break;
      case AppRoute.detailedEpisode:
        if (args.isNotEmpty || isPoping) {
          _currentRoute = 3;
          _routeStack.add(route);
          _currentPage = DetailedEpisodeView(episodeId: args);
        }
        break;
      default:
        _currentRoute = -1;
        _routeStack.add(AppRoute.error);
        _currentPage = const ErrorView();
    }
    notifyListeners();
  }

  void pop() {
    if (_routeStack.last == AppRoute.home) {
      return;
    }

    _routeStack.removeLast();
    gotoRoute(_routeStack.last, isPoping: true);

    if (_routeStack.last == AppRoute.home) {
      return;
    }
    _routeStack.removeLast(); // Remove the duplicated route added by gotoRoute
  }
}
