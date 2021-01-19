class Constant {
  //***  Variables para el menu de las vista  ***/
  static const String forDefault = 'Por defecto';
  static const String playAudio = 'Audio';
  static const List<String> choices = <String>[ forDefault, playAudio ]; 

  //***  Variables para el tamaño de la fuente de las vistas  ***/
  static double sizeTitle = 23.0;
  static double sizeTitleStanza = 21.0;
  static double sizeStanza = 19.0;

  //***  Variables para la base de datos  ***/
  static final String NAME_DB = 'DataIDMJI.db';
  static final int VERSION_DB = 1;
  static final String NAME_TABLE_HIMNOS = 'Himnos';
  static final String CREATE_TABLE_HIMNOS = 'CREATE TABLE $NAME_TABLE_HIMNOS ('
          ' id INTEGER PRIMARY KEY,'
          ' title TEXT,'
          ' stanzas BLOC'
          ')';  
  static final String QUERY_FOR_ID = 'id = ?';
  static final String NAME_TABLE_COROS = '';

}