class ResponseMedication {
  final int id;
  final String medicationName;
  final int dose;
  final String hour;
  final bool taken;
  final int patientId;
  final int caregiverId;

  ResponseMedication({
    required this.id,
    required this.medicationName,
    required this.dose,
    required this.hour,
    required this.taken,
    required this.patientId,
    required this.caregiverId,
  });

  factory ResponseMedication.fromJson(Map<String, dynamic> json) {
    return ResponseMedication(
      id: json['id'],
      medicationName: json['medicationName'],
      dose: json['dose'],
      hour: json['hour'],
      taken: json['taken'],
      patientId: json['patientId'],
      caregiverId: json['caregiverId'],
    );
  }
}
