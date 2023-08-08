import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

import '../utils/errors_enum.dart';
import 'collection_provider.dart';
import '../models/episode.dart';
import '../utils/api_client.dart';

class EpisodesProvider extends CollectionProvider with ChangeNotifier {
  final ApiClient _gqlClient = ApiClient.instance();
  bool _isLoading = true;

  // All Episodes Related
  int _currentPage = 1;
  int _maxPages = 1;
  int? _nextPage;
  int? _prevPage;

  Errors? _exeption;

  List<Episode> _episodeList = [];

  String _searchTerm = '';

  List<Episode> get episodeList => _episodeList;
  @override
  int get currentPage => _currentPage;
  @override
  int get maxPages => _maxPages;
  @override
  int? get nextPage => _nextPage;
  @override
  int? get prevPage => _prevPage;

  bool get isLoading => _isLoading;

  Errors? get exeption => _exeption;

  @override
  set currentPage(page) {
    _currentPage = page;
    getAllEpisodes();
  }

  void getAllEpisodes() async {
    _exeption = null;

    _isLoading = true;
    notifyListeners();

    try {
      QueryResult res = await _gqlClient.query(
        """query {
              episodes(page: $_currentPage, filter: {name: "$_searchTerm"}){
                info{
                  pages
                  prev
                  next
                }
                results{
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

      _maxPages = res.data!['episodes']['info']['pages'];
      _nextPage = res.data!['episodes']['info']['next'];
      _prevPage = res.data!['episodes']['info']['prev'];

      _episodeList = (res.data!['episodes']['results'] as List)
          .map((json) => Episode.fromJson(json))
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
    getAllEpisodes();
  }

  // Specific Episode Related

  Episode currentInspected = Episode.fromJson({
    'id': '-1',
    'name': 'Loadig',
    'type': 'Loadig',
    'dimension': 'Loadig',
  });

  void getepisodeInfo(String episodeId) async {
    _exeption = null;

    if (episodeId.isEmpty) {
      episodeId = currentInspected.id;
    }

    _isLoading = true;
    notifyListeners();

    try {
      QueryResult res = await _gqlClient.query(
        """query {
          episode(id: $episodeId) {
            id
            name
            air_date
            episode
            characters {
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

      currentInspected = Episode.fromJson(res.data!['episode']);
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
