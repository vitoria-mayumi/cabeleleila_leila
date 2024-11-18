import 'package:cabeleileila/model/scheduling/scheduling_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SchedulingService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _schedulingReference;

  SchedulingService() {
    _schedulingReference = _firestore
        .collection("scheduling")
        .withConverter<Scheduling>(
            fromFirestore: (snapshots, _) =>
                Scheduling.fromJson(snapshots.data()!),
            toFirestore: (scheduling, _) => scheduling.toJson());
  }

  Stream<QuerySnapshot> getAll() {
    return _schedulingReference.snapshots();
  }

  void add(Scheduling scheduling) async {
    _schedulingReference.add(scheduling);
  }

  void update(String idScheduling, Scheduling scheduling) {
    _schedulingReference.doc(idScheduling).update(scheduling.toJson());
  }

  void delete(String idScheduling) {
    _schedulingReference.doc(idScheduling).delete();
  }

  Future<int?> getLastId() async {
    final query = await _schedulingReference
        .orderBy('id', descending: true)
        .limit(1)
        .get();

    final lastScheduling = query.docs.first.data() as Scheduling;
    return lastScheduling.id;
  }
}
