class Himnos {
  List<Himno> listHimnos = List();

  Himnos();

  Himnos.fromJsonList( List<dynamic> jsonList ) {
    if ( jsonList == null ) return;

    for ( var item in jsonList ) {
      final himno = Himno.fromJsonMap( item );      
      listHimnos.add( himno );
    }
  }

}

class Himno {  
  int id;
  String title;
  List<dynamic> stanzas;

  Himno({
    this.id,
    this.title,
    this.stanzas
  });

  factory Himno.fromJsonMap( Map<String, dynamic> json ) => Himno(
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