import 'package:idmji/src/models/himno_model.dart';
import 'package:idmji/src/providers/data_provoder.dart';
import 'package:rxdart/rxdart.dart';

class HimnosBloc {
  final _himnosController = BehaviorSubject<List<Himno>>();

  dispose() => _himnosController?.close();

  final _dataProvider = DataProvider();

  Stream<List<Himno>> get himnosStream => _himnosController.stream;

  void getHimnos() async {
    final listHimnos = await _dataProvider.getHimnos();
    _himnosController.sink.add( listHimnos );
  }
}