class ResponsePatient {
  final int id;
  final String name;
  final String lastName;
  final String birthDate;
  final String address;

  ResponsePatient({
    required this.id,
    required this.name,
    required this.lastName,
    required this.birthDate,
    required this.address,
  });

  factory ResponsePatient.fromJson(Map<String, dynamic> json) {
    return ResponsePatient(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      birthDate: json['birthDate'],
      address: json['address'],
    );
  }
}
