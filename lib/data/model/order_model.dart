import 'order_drug_model.dart';

class OrderModel {
  final int id;
  final int adminId;
  final String pharmacyName;
  final String status;
  final int userId;
  final double totalPrice;
  final List<OrderDrugModel> orderItems;
  final String imageUrl;
  bool isOpen = false;

  OrderModel({
    required this.id,
    required this.adminId,
    required this.pharmacyName,
    required this.status,
    required this.userId,
    required this.totalPrice,
    required this.orderItems,
    required this.imageUrl,
  });

  factory OrderModel.zero() {
    return OrderModel(
      id: 0,
      adminId: 0,
      pharmacyName: '',
      status: '',
      userId: 0,
      totalPrice: 0,
      orderItems: [],
      imageUrl: '',
    );
  }

  factory OrderModel.fromJsom(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      adminId: json['adminId'] ?? json['admin']['id'],
      pharmacyName: json['pharmacyName'] ?? '',
      status: json['status'] ?? '',
      userId: json['userId'] ?? json['user']['id'],
      totalPrice: json['totalPrice'] ?? 0.0,
      orderItems: OrderDrugModel.map(json['orderItems'] ?? []),
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  static List<OrderModel> map(List<dynamic> response) {
    return response
        .map((item) => OrderModel.fromJsom(item))
        .cast<OrderModel>()
        .toList();
  }
}
