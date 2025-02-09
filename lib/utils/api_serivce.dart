import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<dynamic>> fetchMenu() async {
    try {
      final response = await http.get(
        Uri.parse("https://faheemkodi.github.io/mock-menu-api/menu.json"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        print("${response.body}");

        if (data.containsKey('categories')) {
          final categories = data['categories'];

          for (var category in categories) {
            print("🔗 Category Image URL: ${category['image_url']}");
            if (category.containsKey('dishes')) {
              for (var dish in category['dishes']) {
                print("🍽 Dish Image URL: ${dish['image_url']}");
              }
            }
          }

          return categories;
        } else {
          print("❌ 'categories' key not found.");
          return [];
        }
      } else {
        print("❌ API Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("❌ API Fetch Error: $e");
      return [];
    }
  }
}
