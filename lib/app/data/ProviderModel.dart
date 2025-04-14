class ProviderModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String profileImageUrl;
  final String bio;
  final List<String> givenServices;
  final double? rating;

  ProviderModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImageUrl,
    required this.bio,
    required this.givenServices,
    this.rating,
  });

  factory ProviderModel.fromMap(Map<String, dynamic> map) {
    return ProviderModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      profileImageUrl:
          map['profileImageUrl'] ??
          'https://static.vecteezy.com/system/resources/thumbnails/054/078/108/small_2x/cartoon-character-of-a-construction-worker-vector.jpg',
      bio: map['bio'] ?? '',
      givenServices:
          (map['givenServices'] as List<dynamic>?)?.cast<String>() ?? [],

      rating: map['rating'] != null ? (map['rating'] as num).toDouble() : 4.5,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'bio': bio,
      'givenServices': givenServices,
      'rating': rating,
    };
  }
}
