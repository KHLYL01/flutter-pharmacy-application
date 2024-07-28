import 'package:pharmacy_managment_system/data/model/drug_model.dart';

class FavoriteModel {
  final int id;
  final int userId;
  final DrugModel drug;
  final int drugAdminId;
  final String drugPharmacy;

  FavoriteModel({
    required this.id,
    required this.userId,
    required this.drug,
    required this.drugAdminId,
    required this.drugPharmacy,
  });

  factory FavoriteModel.fromJsom(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'],
      userId: json['user']['id'],
      drug: DrugModel.fromJsom(json['drug']),
      drugPharmacy: json['drug']['category']['admin']['pharmacyName'],
      drugAdminId: json['drug']['category']['admin']['id'],
    );
  }

  factory FavoriteModel.zero() {
    return FavoriteModel(
      id: 0,
      userId: 0,
      drug: DrugModel.zero(),
      drugAdminId: 0,
      drugPharmacy: '',
    );
  }

  static List<FavoriteModel> map(response) {
    return response
        .map((item) => FavoriteModel.fromJsom(item))
        .cast<FavoriteModel>()
        .toList();
  }
}
