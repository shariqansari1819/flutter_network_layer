import 'package:flutter_network_layer/models/chuck_response.dart';
import 'package:flutter_network_layer/networking/api_provider.dart';

class ChuckRepository {
  ApiProvider _apiProvider = ApiProvider();

  Future<ChuckResponse> fetchChuckJoke(String category) async {
    final response =
        await _apiProvider.get("jokes/random?category=" + category);
    return ChuckResponse.fromJson(response);
  }
}
