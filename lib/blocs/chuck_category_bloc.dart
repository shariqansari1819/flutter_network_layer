import 'dart:async';

import 'package:flutter_network_layer/models/chuck_category.dart';
import 'package:flutter_network_layer/networking/response.dart';
import 'package:flutter_network_layer/repository/chuck_category_repository.dart';

class ChuckCategoryBloc {
  ChuckCategoryRepository _chuckCategoryRepository;
  StreamController _chuckListController;

  StreamSink<Response<ChuckCategory>> get chuckListSink =>
      _chuckListController.sink;

  Stream<Response<ChuckCategory>> get chuckListStream =>
      _chuckListController.stream;

  ChuckCategoryBloc() {
    _chuckListController = StreamController<Response<ChuckCategory>>();
    _chuckCategoryRepository = ChuckCategoryRepository();
    fetchCategories();
  }

  fetchCategories() async {
    chuckListSink.add(Response.loading("Getting chuck categories"));
    try {
      ChuckCategory category =
          await _chuckCategoryRepository.fetchChuckCategoriesData();
      chuckListSink.add(Response.completed(category));
    } catch (e) {
      chuckListSink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    _chuckListController?.close();
  }
}
