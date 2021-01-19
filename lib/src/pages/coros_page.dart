import 'package:flutter/material.dart';
import 'package:idmji/src/bloc/data_bloc.dart';
import 'package:idmji/src/search/search_delegate.dart';
import 'package:idmji/src/utils/utils.dart' as utils;

class CorosPage extends StatelessWidget {

  @override
  Widget build( BuildContext context ) {
    final corosBloc = DataBloc();
    corosBloc.getCoros();
    
    return Scaffold(
      appBar: AppBar(
        title: Text( 'Coros' ),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search ),
            onPressed: () => showSearch( context: context, delegate: DataSearch( 'Coro' ) ),
          )
        ],
      ),
      body: _createListCoros( corosBloc )
    );
  }

  Widget _createListCoros( DataBloc corosBloc ) {
    return StreamBuilder(
      stream: corosBloc.corosStream,
      builder: ( BuildContext context, AsyncSnapshot<List<dynamic>> snapshot ) {
        if ( snapshot.hasData ) {          
          return ListView( children: utils.createItems( context, snapshot.data, 'Coro' ) );
        } else {
          return Center( child: CircularProgressIndicator() );
        }
      },
    );
  }

}