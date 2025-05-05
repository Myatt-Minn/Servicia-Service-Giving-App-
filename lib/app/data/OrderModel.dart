class OrderModel {
  final int? id;
  final String serviceId;
  final String serviceTitle;
  final String customerId;
  final String providerId;
  final DateTime serviceingDate; // When customer wants the service
  final DateTime createdAt; // When the order was placed
  final String
  status; // e.g., "pending", "accepted", "in_progress", "completed", "cancelled"
  final int totalPrice;
  final String address;

  OrderModel({
    this.id,
    required this.serviceId,
    required this.serviceTitle,
    required this.customerId,
    required this.providerId,
    required this.serviceingDate,
    required this.createdAt,
    required this.status,
    required this.totalPrice,
    required this.address,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      serviceId: map['serviceId'],
      serviceTitle: map['serviceTitle'],
      customerId: map['customerId'],
      providerId: map['providerId'],
      serviceingDate: DateTime.parse(map['serviceingDate']),
      createdAt: DateTime.parse(map['createdAt']),
      status: map['status'],
      totalPrice: map['totalPrice'] as int,

      address: map['address'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serviceId': serviceId,
      'serviceTitle': serviceTitle,
      'customerId': customerId,
      'providerId': providerId,
      'serviceingDate': serviceingDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'totalPrice': totalPrice,

      'address': address,
    };
  }
}
