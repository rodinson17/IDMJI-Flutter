import 'package:flutter/material.dart';
import 'package:idmji/src/bloc/data_bloc.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build( BuildContext context ) {
    final himnosBloc = DataBloc();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createFound( context ),
          _createButtons( context )
        ],
      ),
      /* floatingActionButton: FloatingActionButton(
        child: Icon( Icons.control_point ),
        onPressed: () => Navigator.pushNamed( context, 'prueba'),
      ), */
    );
  }

  Widget _createFound( BuildContext context ) {  
    //final size = MediaQuery.of( context ).size; 

    final foundGradiant = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color> [
            Color.fromRGBO( 255, 255, 255, 1.0 ), 
            Color.fromRGBO( 0, 85, 221, 1.0 ),
            Color.fromRGBO( 255, 255, 255, 1.0 ), 
          ]
        )
      ),
    );

    return Stack(
      children: <Widget>[
        foundGradiant,
        Container(
          padding: EdgeInsets.symmetric( vertical: 200.0, horizontal: 80.0 ),
          //padding: EdgeInsets.symmetric( vertical: 150.0, horizontal: 80.0 ), //cel peq
          child: Image(
            image: AssetImage( 'assets/logo_idmji.png' ),
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

  Widget _createButtons( BuildContext context ) {
    final size = MediaQuery.of( context ).size;

    return Column(
      children: <Widget>[
        SafeArea( child: Container( height: 300.0 ) ),
        //SafeArea( child: Container( height: size.height * 0.4 ) ), //cel peq
        Container(
          width: size.width * 0.7,
          margin: EdgeInsets.symmetric( vertical: 50.0 ),
          padding: EdgeInsets.symmetric( vertical: 30.0 ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular( 5.0 ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                offset: Offset( 0.0, 5.0 ),
                spreadRadius: 3.0
              )
            ]
          ),
          child: Column(
            children: <Widget>[              
              _createButtonHimnos( context ),
              SizedBox( height: 40.0 ),
              _createButtonCoros( context )
            ],
          ),
        )
      ],
    );
  }

  Widget _createButtonHimnos( BuildContext context ) {
    return FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text( 'Himnos', style: TextStyle( fontSize: 30.0 ) ),
                SizedBox( width: 30.0 ),
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular( 100.0 ),
                    color: Colors.grey
                  ),
                  child: Icon( Icons.keyboard_tab, color: Colors.white ),
                )
              ],
            ),
            onPressed: () => Navigator.pushNamed( context, 'himnos' ),
          );
  }

  Widget _createButtonCoros( BuildContext context ) {
    return FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text( 'Coros', style: TextStyle( fontSize: 30.0 ) ),
                SizedBox( width: 55.0 ),
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular( 100.0 ),
                    color: Colors.grey
                  ),
                  child: Icon( Icons.keyboard_tab, color: Colors.white ),
                )
              ],
            ),
            onPressed: () => Navigator.pushNamed( context, 'coros' ),
          );
  }
}