class OrderModel {
  final String id;
  final String serviceId;
  final String serviceTitle;
  final String customerId;
  final String providerId;
  final DateTime bookingDate; // When customer wants the service
  final DateTime createdAt; // When the order was placed
  final String
  status; // e.g., "pending", "accepted", "in_progress", "completed", "cancelled"
  final int totalPrice;
  final String? notes; // Optional customer notes or special requests
  final String address;

  OrderModel({
    required this.id,
    required this.serviceId,
    required this.serviceTitle,
    required this.customerId,
    required this.providerId,
    required this.bookingDate,
    required this.createdAt,
    required this.status,
    required this.totalPrice,
    required this.address,
    this.notes,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'],
      serviceId: map['serviceId'],
      serviceTitle: map['serviceTitle'],
      customerId: map['customerId'],
      providerId: map['providerId'],
      bookingDate: DateTime.parse(map['bookingDate']),
      createdAt: DateTime.parse(map['createdAt']),
      status: map['status'],
      totalPrice: map['totalPrice'] as int,
      notes: map['notes'],
      address: map['address']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'serviceId': serviceId,
      'serviceTitle': serviceTitle,
      'customerId': customerId,
      'providerId': providerId,
      'bookingDate': bookingDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'totalPrice': totalPrice,
      'notes': notes,
      'address': address,
    };
  }
}
