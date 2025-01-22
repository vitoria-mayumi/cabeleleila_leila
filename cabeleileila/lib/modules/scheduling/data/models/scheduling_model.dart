import 'package:cabeleileila/modules/scheduling/domain/entities/scheduling.dart';

class SchedulingModel extends Scheduling {
  SchedulingModel({
    super.id,
    required super.idUser,
    required super.serviceType,
    required super.dateHour,
    required super.status,
  });

  factory SchedulingModel.fromMap(Map<String, dynamic> map) => SchedulingModel(
        id: map['id'],
        idUser: map['userId'],
        serviceType: map['serviceType'],
        dateHour: map['dateHour'],
        status: map['status'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'idUser': idUser,
        'serviceType': serviceType,
        'dateHour': dateHour,
        'status': status,
      };
}
