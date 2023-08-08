abstract class CollectionProvider {
  int _currentPage = 1;
  final int _maxPages = 1;
  int? _nextPage;
  int? _prevPage;

  int get currentPage => _currentPage;
  int get maxPages => _maxPages;
  int? get nextPage => _nextPage;
  int? get prevPage => _prevPage;

  set currentPage(page) {
    _currentPage = page;
  }

  set searchTerm(String value) {}
}
