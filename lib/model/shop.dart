class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final double? originalPrice;
  final String description;
  final String imageUrl;
  final List<String>? additionalImages;
  final double rating;
  final int reviewCount;
  final bool inStock;
  bool isFavorite;
  final List<String>? features;
  final Map<String, String>? specifications;
  final List<String>? relatedProducts;
  final List<Review>? reviews;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.description,
    required this.imageUrl,
    this.additionalImages,
    required this.rating,
    required this.reviewCount,
    required this.inStock,
    this.isFavorite = false,
    this.features,
    this.specifications,
    this.relatedProducts,
    this.reviews,
  });
}

// New Review class to store user reviews
class Review {
  final String id;
  final String userName;
  final String? userImage;
  final double rating;
  final String comment;
  final DateTime date;
  final List<String>? images;
  final int helpfulCount;
  final bool verified;

  Review({
    required this.id,
    required this.userName,
    this.userImage,
    required this.rating,
    required this.comment,
    required this.date,
    this.images,
    this.helpfulCount = 0,
    this.verified = false,
  });
}
