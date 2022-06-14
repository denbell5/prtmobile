extension ListAppExtensions<E> on List<E> {
  List<T> selectMany<T>(List<T> Function(E x) selector) {
    final result = <T>[];
    for (var trackset in this) {
      result.addAll(selector(trackset));
    }
    return result;
  }

  List<T> mapList<T>(T Function(E x) selector) {
    return map(selector).toList();
  }
}
