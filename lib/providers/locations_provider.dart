import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

import 'collection_provider.dart';
import '../utils/errors_enum.dart';
import '../models/location.dart';
import '../utils/api_client.dart';

/// A service like provider to fetch information about the locations
class LocationsProvider extends CollectionProvider with ChangeNotifier {
  final ApiClient _gqlClient = ApiClient.instance();
  bool _isLoading = true;

  // All Locations Related
  int _currentPage = 1;
  int _maxPages = 1;
  int? _nextPage;
  int? _prevPage;

  String _searchTerm = '';

  Errors? _exeption;

  List<Location> _locationList = [];

  List<Location> get locationList => _locationList;

  /// Pagination Getters
  @override
  int get currentPage => _currentPage;
  @override
  int get maxPages => _maxPages;
  @override
  int? get nextPage => _nextPage;
  @override
  int? get prevPage => _prevPage;

  /// Flag Variables
  bool get isLoading => _isLoading;

  Errors? get exeption => _exeption;

  @override
  set currentPage(page) {
    _currentPage = page;
    getAllLocations();
  }

  void getAllLocations() async {
    _exeption = null;

    _isLoading = true;
    notifyListeners();

    try {
      QueryResult res = await _gqlClient.query(
        """query {
              locations(page: $_currentPage, filter: {name: "$_searchTerm"}){
                info{
                  pages
                  prev
                  next
                }
                results{
                  id
                  name
                  type
                }
              }
            }
            """,
      );

      if (res.hasException) {
        if (res.exception!.graphqlErrors.isNotEmpty) {
          throw res.exception!.graphqlErrors;
        } else {
          throw NetworkException.fromException(
              originalException:
                  res.exception!.linkException!.originalException!,
              originalStackTrace:
                  res.exception!.linkException!.originalStackTrace!,
              uri: Uri());
        }
      }

      _maxPages = res.data!['locations']['info']['pages'];
      _nextPage = res.data!['locations']['info']['next'];
      _prevPage = res.data!['locations']['info']['prev'];

      _locationList = (res.data!['locations']['results'] as List)
          .map((json) => Location.fromJson(json))
          .toList();
    } on ServerException catch (_) {
      _exeption = Errors.serverError;
    } on List<GraphQLError> catch (_) {
      _exeption = Errors.serverError;
    } on NetworkException catch (_) {
      _exeption = Errors.connectionError;
    } catch (error) {
      _exeption = Errors.internalError;
      rethrow;
    }

    _isLoading = false;
    notifyListeners();
  }

  @override
  set searchTerm(String value) {
    _searchTerm = value;
    getAllLocations();
  }

  // Specific Location Related

  Location currentInspected = Location.fromJson({
    'id': '-1',
    'name': 'Loadig',
    'type': 'Loadig',
    'dimension': 'Loadig',
  });

  void getlocationInfo(String locationId) async {
    _exeption = null;

    if (locationId.isEmpty) {
      locationId = currentInspected.id;
    }
    _isLoading = true;
    notifyListeners();

    try {
      QueryResult res = await _gqlClient.query(
        """query {
          location(id: $locationId) {
            id
            name
            type
            dimension
            residents {
              id
              name
              species
            }
          }
        }
          """,
      );

      if (res.hasException) {
        if (res.exception!.graphqlErrors.isNotEmpty) {
          throw res.exception!.graphqlErrors;
        } else {
          throw NetworkException.fromException(
              originalException:
                  res.exception!.linkException!.originalException!,
              originalStackTrace:
                  res.exception!.linkException!.originalStackTrace!,
              uri: Uri());
        }
      }

      currentInspected = Location.fromJson(res.data!['location']);
    } on ServerException catch (_) {
      _exeption = Errors.serverError;
    } on List<GraphQLError> catch (_) {
      _exeption = Errors.serverError;
    } on NetworkException catch (_) {
      _exeption = Errors.connectionError;
    } catch (error) {
      _exeption = Errors.internalError;
      rethrow;
    }

    _isLoading = false;
    notifyListeners();
  }
}
