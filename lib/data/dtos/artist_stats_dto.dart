import 'package:json_annotation/json_annotation.dart';

part 'artist_stats_dto.g.dart';

@JsonSerializable(createToJson: false)
class ArtistStatsDto {
  final String? artistName;
  final int? albumCount;

  const ArtistStatsDto({
    this.artistName,
    this.albumCount,
  });

  factory ArtistStatsDto.fromJson(Map<String, dynamic> json) =>
      _$ArtistStatsDtoFromJson(json);
}