class Filme {
  bool adult;
  String backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Filme({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Filme.fromJsonMap(Map<String, dynamic> registroFilmeJson) {
    adult = registroFilmeJson['adult'];
    backdropPath = registroFilmeJson['backdrop_path'];
    genreIds = registroFilmeJson['genre_ids'].cast<int>();
    id = registroFilmeJson['id'];
    originalLanguage = registroFilmeJson['original_language'];
    originalTitle = registroFilmeJson['original_title'];
    overview = registroFilmeJson['overview'];
    popularity = registroFilmeJson['popularity'];
    posterPath = registroFilmeJson['poster_path'];
    releaseDate = registroFilmeJson['release_date'];
    title = registroFilmeJson['title'];
    video = registroFilmeJson['video'];
    voteAverage = registroFilmeJson['vote_average'] / 1;
    voteCount = registroFilmeJson['vote_count'];
  }

  getImagemPoster() {
    if (posterPath == null) {
      return 'https://semantic-ui.com/images/wireframe/white-image.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackgroundPoster() {
    if (posterPath == null) {
      return 'https://semantic-ui.com/images/wireframe/white-image.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}
