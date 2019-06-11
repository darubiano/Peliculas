class InfoActores {

  String birthday;
  String knownForDepartment;
  dynamic deathday;
  int id;
  String name;
  List<String> alsoKnownAs;
  int gender;
  String biography;
  double popularity;
  String placeOfBirth;
  String profilePath;
  bool adult;
  String imdbId;
  dynamic homepage;

  InfoActores({
    this.birthday,
    this.knownForDepartment,
    this.deathday,
    this.id,
    this.name,
    this.alsoKnownAs,
    this.gender,
    this.biography,
    this.popularity,
    this.placeOfBirth,
    this.profilePath,
    this.adult,
    this.imdbId,
    this.homepage,
  });

  factory  InfoActores.fromJson(Map<String, dynamic> json){
    
    return InfoActores(

      birthday           : json['birthday'],
      knownForDepartment : json['known_for_department'],
      deathday           : json['deathday'],
      id                 : json['id'],
      name               : json['name'],
      //alsoKnownAs        : json['also_known_as'],
      gender             : json['gender'],
      biography          : json['biography'],
      popularity         : json['popularity'],
      placeOfBirth       : json['place_of_birth'],
      profilePath        : json['profile_path'],
      adult              : json['adult'],
      imdbId             : json['imdb_id'],
      homepage           : json['homepage'],

    );


  }

  getActorImg(){

    if (profilePath!=null){
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }else{
      return 'https://institutogoldenprana.com.br/wp-content/uploads/2015/08/no-avatar-25359d55aa3c93ab3466622fd2ce712d1.jpg';
    }
    
  }


}
