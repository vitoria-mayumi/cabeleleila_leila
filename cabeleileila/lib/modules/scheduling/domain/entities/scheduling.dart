class Scheduling {
  final int? id;
  final int idUser;
  final String serviceType;
  final String dateHour;
  final String status;

  Scheduling({
    this.id,
    required this.idUser,
    required this.serviceType,
    required this.dateHour,
    required this.status,
  });
}
