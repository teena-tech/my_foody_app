class PropertyModel {
  final String title;
  final String imageUrl;
  final String price;

  PropertyModel({
    required this.title,
    required this.imageUrl,
    required this.price,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      title: json['title'] ?? 'Luxury Villa',
      imageUrl: json['property_image'] ?? '',
      price: "${json['currency'] ?? '₹'} ${json['price']?.toString() ?? '0'}",
    );
  }
}
