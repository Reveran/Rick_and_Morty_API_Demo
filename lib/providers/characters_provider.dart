import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

import '../utils/errors_enum.dart';
import 'collection_provider.dart';
import '../models/character.dart';
import '../utils/api_client.dart';

/// A service like provider to fetch information about the Characters
class CharactersProvider with ChangeNotifier implements CollectionProvider {
  final ApiClient _gqlClient = ApiClient.instance();
  bool _isLoading = true;

  // All Characters Related
  int _currentPage = 1;
  int _maxPages = 1;
  int? _nextPage;
  int? _prevPage;

  String _searchTerm = '';

  Errors? _exeption;

  List<Character> _characterList = [];

  List<Character> get characterList => _characterList;

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
    getAllCharacters();
  }

  void getAllCharacters() async {
    _exeption = null;

    _isLoading = true;
    notifyListeners();

    try {
      QueryResult res = await _gqlClient.query(
        """query {
          characters(page: 1, filter: {name: "$_searchTerm"}) {
            info {
              pages
              prev
              next
            }
            results {
              id
              name
              status
              image
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

      _maxPages = res.data!['characters']['info']['pages'];
      _nextPage = res.data!['characters']['info']['next'];
      _prevPage = res.data!['characters']['info']['prev'];

      _characterList = (res.data!['characters']['results'] as List)
          .map((json) => Character.fromJson(json))
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
    getAllCharacters();
  }

  // Specific Character Related

  Character currentInspected = Character.fromJson({
    'id': '-1',
    'name': 'Loadig',
    'status': 'Loadig',
  });

  void getcharacterInfo(String characterId) async {
    _exeption = null;

    if (characterId.isEmpty) {
      characterId = currentInspected.id;
    }
    _isLoading = true;
    notifyListeners();

    try {
      QueryResult res = await _gqlClient.query(
        """query {
          character(id: $characterId) {
            id
            name
            status
            image
            species
              type
              gender
              origin{
                id
                name
                dimension
              }
              location{
                id
                name
                dimension
              }
              episode{
                id
                name
                episode
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

      currentInspected = Character.fromJson(res.data!['character']);
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
