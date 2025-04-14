import 'package:x_book_shelf/app/data/ProviderModel.dart';

class ServiceModel {
  final String id;
  final String title;
  final String description;
  final String category; // e.g., "Car Repair", "House Painting"
  final int price; // can be hourly or fixed based on `pricingType`
  final String pricingType; // "fixed" or "hourly"
  final ProviderModel provider; // user ID of the service provider
  final String location; // optional, can be city or full address
  final String imageUrl;
  final DateTime createdAt;
  final double? rating; // average rating, nullable if no reviews yet
  final String phoneNumber;

  ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.pricingType,
    required this.provider,
    required this.location,
    required this.imageUrl,
    required this.phoneNumber,
    required this.createdAt,
    this.rating,
  });

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['service_id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      price: map['price'] as int,
      pricingType: map['pricingType'] as String,
      provider: ProviderModel.fromMap(map['provider'] as Map<String, dynamic>),
      location: map['location'] as String,
      imageUrl: map['imageUrl'] as String,
      createdAt: DateTime.parse(map['createdAt']),
      phoneNumber: map['phoneNumber'] as String,
      rating: map['rating'] != null ? (map['rating'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'service_id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'pricingType': pricingType,
      'provider': provider,
      'location': location,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt.toIso8601String(),
      'rating': rating,
    };
  }
}
