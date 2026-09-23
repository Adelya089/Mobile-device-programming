enum Genre {
  pop,
  rock,
  rap,
}

extension GenreExtension on Genre {
  String get title {
    switch (this) {
      case Genre.pop:
        return 'Поп';
      case Genre.rock:
        return 'Рок';
      case Genre.rap:
        return 'Рэп';
    }
  }
}

class Album {
  String name;
  int year;
  Genre genre;

  Album(this.name, this.year, this.genre);

  void showInfo() {
    print('$name, $year, жанр: ${genre.title}');
  }
}

class Artist {
  String name;
  List<Album> albums;

  Artist(this.name, this.albums);

  void showAlbums() {
    print('Исполнитель: $name');

    for (Album album in albums) {
      album.showInfo();
    }
  }
}

Future<void> loadAlbums() async {
  print('Загрузка');

  await Future.delayed(const Duration(seconds: 1));

  print('Загрузка завершена');
}


Future<void> runLab2() async {
  Album album1 = Album(
    'Альбом 1',
    2020,
    Genre.pop,
  );

  Album album2 = Album(
    'Альбом 2',
    2022,
    Genre.rock,
  );

  Artist artist = Artist(
    'Исполнитель',
    [album1, album2],
  );

  await loadAlbums();

  artist.showAlbums();

  artist.albums.forEach((album) {
    print('Название: ${album.name}');
  });
}