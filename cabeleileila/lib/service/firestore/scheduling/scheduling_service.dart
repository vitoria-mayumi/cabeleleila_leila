import 'package:cabeleileila/core/model/scheduling/scheduling_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SchedulingService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _schedulingReference;

  SchedulingService() {
    _schedulingReference = _firestore.collection("scheduling");
  }

  Future<List<Scheduling>> getAll() async {
    var result = await _schedulingReference.get();

    return result.docs
        .map((doc) => Scheduling(
              id: int.tryParse(doc.reference.id) ?? 0,
              serviceType: doc['serviceType'],
              userId: doc['userId'],
              dateTime: doc['dateTime'],
              status: doc['status'],
            ))
        .toList();
  }

  void add(Scheduling scheduling) async {
    _schedulingReference.doc(scheduling.id.toString()).set({
      'id': scheduling.id,
      'serviceType': scheduling.serviceType,
      'userId': scheduling.userId,
      'dateTime': scheduling.dateTime,
      'status': scheduling.status,
    });
  }

  void update(String idScheduling, Scheduling scheduling) {
    _schedulingReference.doc(idScheduling).update(scheduling.toJson());
  }

  void delete(String idScheduling) {
    _schedulingReference.doc(idScheduling).delete();
  }

  Future<int?> getLastId() async {
    final query = await _schedulingReference.orderBy('id', descending: true).limit(1).get();

    final lastScheduling = query.docs.first.data() as Map;
    return lastScheduling['id']!;
  }
}
