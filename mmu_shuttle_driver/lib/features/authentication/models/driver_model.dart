class DriverModel {
  final int? id;
  final String? email;
  final String? name;
  final String? busPlate;

  DriverModel({this.id, this.email, this.name, this.busPlate});

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'] ?? -1,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      busPlate: json['busPlate'] ?? '',
    );
  }
}
