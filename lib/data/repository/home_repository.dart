import 'package:online_swissy/core/api_service.dart';
import 'package:online_swissy/data/models/property_model.dart';

class HomeRepository {
  final ApiService apiService;

  HomeRepository(this.apiService);

  Future<List<PropertyModel>> getProperties() async {
    try {
      final response = await apiService.fetchHomeData();

      print("Raw API Data: $response");

      if (response.containsKey("top_destinations") &&
          response["top_destinations"] is List) {
        List<PropertyModel> properties = (response["top_destinations"] as List)
            .map((json) => PropertyModel.fromJson(json))
            .toList();
        return properties;
      } else {
        throw Exception("Invalid data format: Missing 'top_destinations'");
      }
    } catch (e) {
      print("Repository Error: $e");
      throw Exception("Error fetching properties");
    }
  }
}
