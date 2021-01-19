import 'package:flutter/material.dart';
import 'package:idmji/src/bloc/himnos_bloc.dart';

class Provider extends InheritedWidget {
  static Provider _instance;
  final _himnosBloc = HimnosBloc();

  factory Provider({ Key key, Widget child }) {
    if ( _instance == null ) _instance = Provider._internal( key: key, child: child );
    return _instance;
  }

  Provider._internal({ Key key, Widget child }) 
    : super( key: key, child: child );

  @override
  bool updateShouldNotify( InheritedWidget oldWidget ) => true;

  static HimnosBloc himnosBloc ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType( Provider ) as Provider )._himnosBloc;
  }

}