import 'package:dio/dio.dart';
import 'package:waka/models/game_room.dart';
import 'package:waka/models/post.dart';
import 'package:waka/utils/constants.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class GameService {
    var dio = Dio();

    Future<List<Post>> fetchPosts({ required int pageNumber, int pageSize = 5 }) async {
        final String requestUrl =   "https://jsonplaceholder.typicode.com/posts?_page=$pageNumber&_limit=$pageSize";
        final response = await dio.get(requestUrl);

        if (response.statusCode == 200) {
            final result = response.data;
            return result.map((post) => Post.fromJson(post)).toList();
        } else {
            throw Exception("Failed to get all rooms");
        }
    }

    Future<List<GameRoom>> fetchOfflineGameRooms({ int pageNumber = 1 }) async {
        final rawData = await rootBundle.loadString("assets/rooms.csv");
        List<List<String>> listData =
                const CsvToListConverter().convert(rawData);
        return Future.delayed(const Duration(milliseconds: Constants.API_DELAY), () {
            return listData.map((row) => GameRoom.fromCSV(row)).toList();
        });
    }

    Future<List<GameRoom>> fetchGameRooms({ int pageNumber = 1 }) async {
        final String requestUrl = "$Constants.REST_API_BASE_URL";
        final response = await dio.get(requestUrl);

        if (response.statusCode == 200) {
            final result = response.data;
            Iterable list = result['rooms'];
            return list.map((room) => GameRoom.fromJson(room)).toList();
        } else {
            throw Exception("Failed to get all rooms");
        }
    }
}
