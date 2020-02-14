import 'package:flutter_network_layer/models/chuck_category.dart';
import 'package:flutter_network_layer/networking/api_provider.dart';

class ChuckCategoryRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<ChuckCategory> fetchChuckCategoriesData() async {
    final response = await _apiProvider.get("jokes/categories");
    return ChuckCategory.fromJson(response);
  }
}
