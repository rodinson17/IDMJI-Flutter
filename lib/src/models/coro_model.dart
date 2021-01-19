class Coros {
  List<Coro> listCoros = List();

  Coros();

  Coros.fromJsonList( List<dynamic> jsonList ) {
    if ( jsonList == null ) return;

    for ( var item in jsonList ) {
      final coro = Coro.fromJsonMap( item );
      listCoros.add( coro );
    }
  }

}

class Coro {  
  int id;
  String title;
  List<dynamic> stanzas;

  Coro({
     this.id,
    this.title,
    this.stanzas
  });

  factory Coro.fromJsonMap( Map<String, dynamic> json ) => Coro(
    id      : json['id'],
    title   : json['title'],
    stanzas : json['stanzas']
  );

  Map<String, dynamic> toJson() => {
    "id"      : id,
    "title"   : title,
    "stanzas" : stanzas
  };
  
}