class DriverModel {
  final String? email;
  final String? name;
  final String? busPlate;

  DriverModel({this.email, this.name, this.busPlate});

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      busPlate: json['busPlate'] ?? '',
    );
  }
}
