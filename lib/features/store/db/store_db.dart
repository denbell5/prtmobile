import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prtmobile/features/store/store.dart';

class TrackingStoreDb {
  late final FirebaseFirestore _db;

  Future<void> init() async {
    await Firebase.initializeApp();
    _db = FirebaseFirestore.instance;
  }

  Future<List<TracksetSo>> getTracksets() async {
    final snapshot = await _db.collection('tracksets').get();
    final tracksets =
        snapshot.docs.map((x) => TracksetSoMaps.fromRaw(x.data())).toList();
    return tracksets;
  }
}
