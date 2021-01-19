import 'package:flutter/material.dart';
import 'package:idmji/src/models/coro_model.dart';
import 'package:idmji/src/utils/utils.dart' as utils;

class CoroDetailPage extends StatelessWidget {

  @override
  Widget build( BuildContext context ) {
    final Coro coro = ModalRoute.of( context ).settings.arguments;

    return Scaffold(
      appBar: AppBar( title: Text( 'Coros' ) ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric( vertical: 30.0, horizontal: 25.0 ),
          child: Column( children: utils.createListStanzas( coro ) ),
        ),
      ),
    );
  }

}