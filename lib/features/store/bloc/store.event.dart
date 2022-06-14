abstract class TrackingStoreEvent {}

class TrackingStoreInitialized extends TrackingStoreEvent {
  final bool isWithFetch;

  TrackingStoreInitialized({
    this.isWithFetch = false,
  });
}

class TrackingStoreFetched extends TrackingStoreEvent {}
