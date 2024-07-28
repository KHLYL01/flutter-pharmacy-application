class DrugModel {
  final int id;
  final String name;
  final String companyName;
  final String scientificName;
  final int price;
  final int quantity;
  final String gauge;
  final String form;
  final bool isRequiredPrescription;
  final int categoryId;
  int count = 0;
  bool isFavorite = false;

  DrugModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.companyName,
    required this.scientificName,
    required this.price,
    required this.quantity,
    required this.gauge,
    required this.form,
    required this.isRequiredPrescription,
  });

  factory DrugModel.fromJsom(Map<String, dynamic> json) {
    return DrugModel(
      id: json['id'],
      name: json['name'],
      companyName: json['companyName'] ?? '',
      scientificName: json['scientificName'] ?? '',
      price: json['price'] ?? 0,
      quantity: json['quantity'] ?? 0,
      gauge: json['gauge'] ?? '',
      form: json['form'] ?? '',
      isRequiredPrescription: json['requiredPrescription'] ?? false,
      categoryId: json['category']['id'] ?? 0,
    );
  }

  factory DrugModel.zero() {
    return DrugModel(
      id: 0,
      categoryId: 0,
      name: '',
      companyName: '',
      scientificName: '',
      price: 0,
      quantity: 0,
      gauge: '',
      form: '',
      isRequiredPrescription: false,
    );
  }

  static List<DrugModel> map(response) {
    return response
        .map((item) => DrugModel.fromJsom(item))
        .cast<DrugModel>()
        .toList();
  }
}
