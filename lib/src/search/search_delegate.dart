import 'package:flutter/material.dart';
import 'package:idmji/src/bloc/data_bloc.dart';
import 'package:idmji/src/models/coro_model.dart';
import 'package:idmji/src/models/himno_model.dart';
import 'package:idmji/src/utils/utils.dart' as utils;

class DataSearch extends SearchDelegate {
  final dataBloc = DataBloc();
  String typeQuery = '';

  DataSearch( String typeQuery ) { this.typeQuery = typeQuery; }

  @override
  List<Widget> buildActions( BuildContext context ) {
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading( BuildContext context ) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close( context, null ),
    );
  }

  @override
  Widget buildResults( BuildContext context ) {
    return Container();
  }

  @override
  Widget buildSuggestions( BuildContext context ) {
    if ( query.isEmpty ) return Container();

    if ( typeQuery == 'Himno' ) {
      return FutureBuilder(
        future: dataBloc.getListFilterHimnos( query ),
        builder: (BuildContext context, AsyncSnapshot<List<Himno>> snapshot) {
          if ( snapshot.hasData ) {          
            return ListView( children: utils.createItems( context, snapshot.data, typeQuery ) );
          } else {
            return Center( child: CircularProgressIndicator() );
          }        
        },
      );
    } else {
      return FutureBuilder(
        future: dataBloc.getListFilterCoros( query ),
        builder: (BuildContext context, AsyncSnapshot<List<Coro>> snapshot) {
          if ( snapshot.hasData ) {          
            return ListView( children: utils.createItems( context, snapshot.data, typeQuery ) );
          } else {
            return Center( child: CircularProgressIndicator() );
          }        
        },
      );
    }    
  }

}