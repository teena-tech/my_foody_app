import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchHomeData() async {
    try {
      Response response =
          await _dio.get("https://dev.easysellrealty.in/api/home");

      print("API Response: ${response.data}");

      return response.data;
    } catch (e) {
      print("API Error: $e");
      throw Exception("Failed to fetch data");
    }
  }
}
