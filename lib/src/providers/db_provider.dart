//import 'dart:io';
import 'package:idmji/src/models/himno_model.dart';
import 'package:idmji/src/utils/constant.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:path/path.dart';
//import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database _database; 
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if ( _database != null ) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    /* Directory documentsDirectory =  await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, Constant.NAME_DB ); */

    return await openDatabase( 
      //path,
      '',
      version: Constant.VERSION_DB,
      onOpen: (db) { },
      onCreate: ( Database db, int version ) async {
        await db.execute( Constant.CREATE_TABLE_HIMNOS );
      }
    );
  }

  // INSERT - Guardar información en la db
  insertNewHimno( Himno newHimno ) async {
    final db   = await database;
    final resp = await db.insert( Constant.NAME_TABLE_HIMNOS, newHimno.toJson() );
    return resp;
  }

  //SELECT - Obtener información
  getHimnoForId( int id ) async {
    final db   = await database;
    final resp = await db.query( Constant.NAME_TABLE_HIMNOS, where: Constant.QUERY_FOR_ID, whereArgs: [id] );
    return resp.isNotEmpty ? Himno.fromJsonMap( resp.first ) : null;
  }

  // SELECT ALL -  obtener todos los registros de la DB
  Future<List<Himno>> getListAll() async {
    final db   = await database;
    final resp = await db.query( Constant.NAME_TABLE_HIMNOS );
    List<Himno> listData = resp.isNotEmpty ? resp.map( (c) => Himno.fromJsonMap( c ) ).toList() : []; 
    return listData;
  }

  // UPDATE - actualizar registros
  Future<int> updateHimno( Himno updateHimno ) async {
    final db   = await database;
    final resp = await db.update( Constant.NAME_TABLE_HIMNOS, updateHimno.toJson(), where: Constant.QUERY_FOR_ID, whereArgs: [updateHimno.id] );
    return resp;
  }

  //DELETE - Eliminar registros
  Future<int> deleteHimno( int id ) async {
    final db   = await database;
    final resp = await db.delete( Constant.NAME_TABLE_HIMNOS, where: Constant.QUERY_FOR_ID, whereArgs: [id] );
    return resp;
  }

  Future<int> deleteAll() async {
    final db   = await database;
    final resp = await db.rawDelete( "DELETE FROM ${ Constant.NAME_TABLE_HIMNOS }" );
    return resp;
  }

}