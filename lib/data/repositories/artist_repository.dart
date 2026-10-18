import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../models/card.dart';
import '../dtos/artist_stats_dto.dart';
import '../mappers/artist_stats_mapper.dart';
import 'api_interface.dart';

class ArtistRepository extends ApiInterface {
  static final Dio _dio = Dio()
    ..interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ),
    );

  static const String _baseUrl = 'http://10.0.2.2:8080';

  @override
  Future<List<CardData>?> loadData({String? q}) async {
    try {
      const String url = '$_baseUrl/api/1.0/artists/stats';

      final response = await _dio.get(
        url,
        queryParameters: {
          'filter': q ?? '',
        },
      );

      final List<dynamic> jsonList = response.data;

      final List<ArtistStatsDto> dto = jsonList
          .map(
            (e) => ArtistStatsDto.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList();

      return dto.map((e) => e.toDomain()).toList();
    } on DioException catch (e) {
      print(e);
      return null;
    }
  }
}