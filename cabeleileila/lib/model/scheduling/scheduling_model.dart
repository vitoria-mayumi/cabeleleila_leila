class Scheduling {
  int? id;
  String serviceType;
  int userId;
  DateTime dateTime;
  String status;

  Scheduling({
    this.id,
    required this.serviceType,
    required this.userId,
    required this.dateTime,
    required this.status,
  });

  factory Scheduling.fromJson(Map<String, dynamic> json) {
    return Scheduling(
      id: json['id'],
      serviceType: json['serviceType'],
      userId: json['userId'],
      dateTime: json['dateTime'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceType': serviceType,
      'userId': userId,
      'dateTime': dateTime,
      'status': status,
    };
  }
}
