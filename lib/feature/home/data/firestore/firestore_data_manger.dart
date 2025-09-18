import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/feature/home/data/model/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreData {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<CollectionReference<EventModel>> _getEvent() async {
    var ref = _firestore
        .collection("event")
        .withConverter(
          fromFirestore: (snapshot, options) =>
              EventModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
    return ref;
  }

  static Future<void> addEvent(EventModel event) async {
    var ref = await _getEvent();
    var doc = ref.doc();
    event.id = doc.id;
    await doc.set(event);
  }

  static Future<List<EventModel>> getEvents([String? id]) async {
    var ref = await _getEvent();
    var data = id == null || id == "1"
        ?  ref.snapshots()
        :  ref.where("categoryId", isEqualTo: id).snapshots();
    List<EventModel> events = [];
    data.listen((event) {
      for (var e in event.docs) {
        events.add(e.data());
      }
    },);

    return events;
  }

  static Future<List<EventModel>> getFav() async {
    var ref = await _getEvent();
    var data = await ref.get();
    List<EventModel> events = [];
    for (var e in data.docs) {
      if ((e.data().users ?? []).contains(
        FirebaseAuth.instance.currentUser?.uid,
      )) {
        events.add(e.data());
      }
    }
    return events;
  }

  static Future<void> toggleFav(EventModel event) async {
    var ref = await _getEvent();
    var doc = ref.doc(event.id);
    if (event.fav) {
      event.users?.remove(FirebaseAuth.instance.currentUser?.uid);
    } else {
      event.users?.add(FirebaseAuth.instance.currentUser!.uid);
    }
    await doc.update({"users": event.users});
  }
}
