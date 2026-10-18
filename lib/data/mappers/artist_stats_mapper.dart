import '../../models/card.dart';
import '../dtos/artist_stats_dto.dart';

const String _imagePlaceholder =
    'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png';

extension ArtistStatsDtoToModel on ArtistStatsDto {
  CardData toDomain() => CardData(
    artistName ?? 'Неизвестный исполнитель',
    album: 'Количество альбомов: ${albumCount ?? 0}',
    imageUrl: _imagePlaceholder,
  );
}