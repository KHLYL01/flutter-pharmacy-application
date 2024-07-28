class OrderDrugModel {
  final int drugId;
  final String drugName;
  final int price;
  int quantity;

  OrderDrugModel({
    required this.drugId,
    required this.drugName,
    required this.quantity,
    required this.price,
  });

  factory OrderDrugModel.zero() {
    return OrderDrugModel(
      drugId: 0,
      drugName: '',
      quantity: 0,
      price: 0,
    );
  }

  factory OrderDrugModel.fromJsom(Map<String, dynamic> json) {
    return OrderDrugModel(
      drugId: json['drugId'],
      drugName: json['drugName'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  static Map<String, dynamic> toJson(OrderDrugModel orderDrugModel) {
    return {
      'drugId': orderDrugModel.drugId,
      'drugName': orderDrugModel.drugName,
      'price': orderDrugModel.price,
      'quantity': orderDrugModel.quantity,
    };
  }

  static List<OrderDrugModel> map(List<dynamic> response) {
    return response
        .map((item) => OrderDrugModel.fromJsom(item))
        .cast<OrderDrugModel>()
        .toList();
  }

  static List<Map<String, dynamic>> unMap(List<OrderDrugModel> orderItems) {
    return orderItems.map((item) => OrderDrugModel.toJson(item)).toList();
  }
}
