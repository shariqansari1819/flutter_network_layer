import 'dart:async';

import 'package:flutter_network_layer/models/chuck_response.dart';
import 'package:flutter_network_layer/networking/response.dart';
import 'package:flutter_network_layer/repository/chuck_repository.dart';

class ChuckBloc {
  ChuckRepository _chuckRepository;
  StreamController _chuckDataController;

  StreamSink<Response<ChuckResponse>> get _chuckResponseSink =>
      _chuckDataController.sink;
  Stream<Response<ChuckResponse>> get _chuckResponseStream =>
      _chuckDataController.stream;

  ChuckBloc(String category) {
    _chuckRepository = ChuckRepository();
    _chuckDataController = StreamController<Response<ChuckResponse>>();
    fetchChuckyJokes(category);
  }

  fetchChuckyJokes(String category) async {
    _chuckResponseSink.add(Response.loading("Getting a Chucky Joke!"));
    try {
      ChuckResponse chuckResponse =
          await _chuckRepository.fetchChuckJoke(category);
      _chuckResponseSink.add(Response.completed(chuckResponse));
    } catch (e) {
      _chuckResponseSink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    _chuckDataController?.close();
  }
}
