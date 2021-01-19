import 'dart:async';
import 'package:idmji/src/models/coro_model.dart';
import 'package:idmji/src/models/himno_model.dart';
import 'package:idmji/src/providers/data_provoder.dart';

class DataBloc {
  static DataBloc _instance;
  final _dataProvider = DataProvider();
  final _himnosController = StreamController<List<Himno>>.broadcast();
  final _corosController = StreamController<List<Coro>>.broadcast();

  factory DataBloc() {
    if ( _instance == null ) _instance = DataBloc._internal();
    
    return _instance;
  }

  DataBloc._internal() { 
    getHimnos(); 
    getCoros();
  }  

  dispose() {
    _himnosController?.close();
    _corosController?.close();
  } 

  Stream<List<Himno>> get himnosStream => _himnosController.stream;
  Stream<List<Coro>> get corosStream => _corosController.stream;

  getHimnos() async {
    final listHimnos = await _dataProvider.getHimnos();  
    _himnosController.sink.add( listHimnos );
  }

  getCoros() async {  
    final listCoros = await _dataProvider.getCoros();  
    _corosController.sink.add( listCoros );
  }

  Future<List<Himno>> getListFilterHimnos( String query ) async {
    return await _dataProvider.getListFilterHimnos( query );  
  }

  Future<List<Coro>> getListFilterCoros( String query ) async {
    return await _dataProvider.getListFilterCoros( query );  
  }

  List<Himno> getListHimnos() {
    return _dataProvider.listHimnos;
  }

  List<Coro> getListCoros() {
    return _dataProvider.listCoros;
  }
  
}