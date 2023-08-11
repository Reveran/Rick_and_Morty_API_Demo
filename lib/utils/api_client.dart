import 'dart:async';

import 'package:graphql/client.dart';
import 'package:rick_and_morty_demo/utils/config_loader.dart';

/// Singletone holding a GraphQL client.
class ApiClient {
  ApiClient._() {
    setup();
  }

  final Completer<void> _setupCompleter = Completer<void>();
  static ApiClient? _apiClient;
  late GraphQLClient? _client;

  static ApiClient instance() {
    _apiClient ??= ApiClient._();
    return _apiClient!;
  }

  void setup() async {
    String? apiBaseUrl = await ConfigLoader.instance().apiBaseUrl;

    final Link link = HttpLink(apiBaseUrl);

    _client = GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    );
    _setupCompleter.complete();
  }

  Future<void> getClientLoaded() => _setupCompleter.future;

  Future<QueryResult> query(document) async {
    await getClientLoaded();
    return _client!.query(QueryOptions(document: gql(document)));
  }
}
