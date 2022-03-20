import 'package:equatable/equatable.dart';

typedef NomalizedListIdGetter<T, I> = I Function(T item);

class NormalizedList<T, I> extends Equatable {
  final Map<I, T> byId;
  final Set<I> all;

  List<T> get entities => all.map((id) => byId[id]!).toList();

  const NormalizedList({
    required this.byId,
    required this.all,
  });

  static NormalizedList<T, I> createEmpty<T, I>() {
    final byId = <I, T>{};
    final all = <I>{};
    return NormalizedList<T, I>(
      byId: byId,
      all: all,
    );
  }

  NormalizedList<T, I> addAll(
    List<T> entities,
    NomalizedListIdGetter<T, I> idGetter,
  ) {
    final updatedById = Map<I, T>.from(byId);
    final updatedAll = [...all];
    for (var entity in entities) {
      final id = idGetter(entity);
      updatedAll.add(id);
      updatedById[id] = entity;
    }
    return NormalizedList<T, I>(
      byId: updatedById,
      all: Set<I>.from(updatedAll),
    );
  }

  NormalizedList<T, I> set(
    T entity, {
    I? id,
    NomalizedListIdGetter<T, I>? idGetter,
  }) {
    final entityId = id ?? idGetter!.call(entity);
    assert(entityId != null);
    final updatedById = Map<I, T>.from(byId);
    updatedById[entityId] = entity;
    return NormalizedList<T, I>(
      byId: updatedById,
      all: Set<I>.from(all)..add(entityId),
    );
  }

  NormalizedList<T, I> remove(
    I id,
  ) {
    final entityId = id;
    assert(entityId != null);
    final updatedById = Map<I, T>.from(byId);
    updatedById.remove(entityId);
    final updatedAll = all.where((element) => element != entityId).toSet();
    return NormalizedList<T, I>(
      byId: updatedById,
      all: updatedAll,
    );
  }

  static NormalizedList<T, I> normalize<T, I>(
    List<T> collection,
    NomalizedListIdGetter<T, I> idGetter,
  ) {
    final normalizedData = NormalizedList.createEmpty<T, I>();

    if (collection.isEmpty) {
      return normalizedData;
    }

    for (var element in collection) {
      final id = idGetter(element);

      final da = <I>{};
      final da2 = <String>{};
      da.add(id);
      da2.add(id as String);
      normalizedData.all.add(id);
      normalizedData.byId[id] = element;
    }

    return normalizedData;
  }

  @override
  String toString() {
    return byId.toString();
  }

  @override
  List<Object> get props => [
        byId,
        all,
      ];

  @override
  bool get stringify => true;
}
