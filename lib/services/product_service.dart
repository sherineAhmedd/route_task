import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductService {
  final String apiUrl = "https://dummyjson.com/products";


  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['products'] as List;
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}

class Product {
  final String title;
  final String description;
  final String thumbnail;
  final double price;
  final double rating;

  Product({required this.title, required this.description, required this.thumbnail, required this.price, required this.rating});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      price: json['price'],
      rating: json['rating'],
    );
  }
}
