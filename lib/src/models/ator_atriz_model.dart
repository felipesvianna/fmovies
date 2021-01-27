class AtorAtriz {  
  int gender;
  int id;
  String name;
  String originalName;  
  String profilePath;
  int castId;
  String character;
  int order;  

  AtorAtriz({
    this.gender,
    this.id,
    this.name,
    this.originalName,
    this.profilePath,
    this.castId,
    this.character,
    this.order,
  });

  AtorAtriz.fromJsonMap(Map<String, dynamic> registroAtorAtrizJson) {
    gender = registroAtorAtrizJson['gender'];
    id = registroAtorAtrizJson['id'];
    name = registroAtorAtrizJson['name'];
    originalName = registroAtorAtrizJson['original_name'];
    profilePath = registroAtorAtrizJson['profile_path'];
    castId = registroAtorAtrizJson['cast_id'];
    character = registroAtorAtrizJson['character'];
    order = registroAtorAtrizJson['order'];
  }

  getFoto() {
    if (profilePath == null) {
      return 'https://ppstma.unievangelica.edu.br/evento/img/no-photo.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}