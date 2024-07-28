class AdminModel {
  final int id;
  final String fullName;
  final String pharmacyName;
  final String phoneNumber;

  AdminModel({
    required this.id,
    required this.fullName,
    required this.pharmacyName,
    required this.phoneNumber,
  });

  factory AdminModel.zero() {
    return AdminModel(
      id: 0,
      fullName: '',
      pharmacyName: '',
      phoneNumber: '',
    );
  }

  factory AdminModel.fromJsom(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'],
      fullName: json['user']['fullName'],
      pharmacyName: json['pharmacyName'],
      phoneNumber: json['phoneNumber'],
    );
  }

  static List<AdminModel> map(List<dynamic> response) {
    return response
        .map((item) => AdminModel.fromJsom(item))
        .cast<AdminModel>()
        .toList();
  }
}
