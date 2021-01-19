import 'package:flutter/material.dart';
import 'package:idmji/src/models/himno_model.dart';
import 'package:idmji/src/utils/utils.dart' as utils;

class HimnoDetailPage extends StatelessWidget {

  @override
  Widget build( BuildContext context ) {
    final Himno himno = ModalRoute.of( context ).settings.arguments;

    return Scaffold(
      appBar: AppBar( title: Text( 'Himnos' ) ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric( vertical: 30.0, horizontal: 25.0 ),
          child: Column( children: utils.createListStanzas( himno ) ),
        ),
      )
    );
  }

}