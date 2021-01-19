import 'package:flutter/material.dart';
import 'package:idmji/src/bloc/data_bloc.dart';
import 'package:idmji/src/search/search_delegate.dart';
import 'package:idmji/src/utils/utils.dart' as utils;

class HimnosPage extends StatelessWidget {

  @override
  Widget build( BuildContext context ) {
    final himnosBloc = DataBloc();
    himnosBloc.getHimnos();

    return Scaffold(
      appBar: AppBar(
        title: Text( 'Himnos' ),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search ),
            onPressed: () => showSearch( context: context, delegate: DataSearch( 'Himno' ) ),
          )
        ],
      ),
      body: _createListHimnos( himnosBloc )
    );
  }

  Widget _createListHimnos( DataBloc himnosBloc ) {
    return StreamBuilder(
      stream: himnosBloc.himnosStream,
      builder: ( BuildContext context, AsyncSnapshot<List<dynamic>> snapshot ) {
        if ( snapshot.hasData ) {          
          return ListView( children: utils.createItems( context, snapshot.data, 'Himno' ) );
        } else {
          return Center( child: CircularProgressIndicator() );
        }
      },
    );
  }

}