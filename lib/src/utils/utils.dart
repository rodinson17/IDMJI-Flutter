import 'package:flutter/material.dart';
import 'package:idmji/src/utils/constant.dart';


// Metodo para crear los items de una lista
List<Widget> createItems( BuildContext context, List<dynamic> data, String text ) {
  final List<Widget> listItems = [];

  data.forEach( (item) {
    final title = item.title.split('.');

    final widgetTemp = ListTile(
      title: Text( '$text ${ item.id }', style: TextStyle( fontSize: 20.0 ) ),
      subtitle: Text( title[1].trim(), style: TextStyle( fontSize: 17.0 ) ),
      trailing: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular( 100.0 ),
                    color: Colors.black26
                  ),
                  child: Icon( Icons.keyboard_tab, color: Colors.white ),
                ),
      onTap: () => Navigator.pushNamed( context, '${text}sPagerView', arguments: item ),
    );

    listItems..add( widgetTemp )
              ..add( Divider() );
  });

  return listItems;
}


// Metodo que retorna una lista de widgets para la creacion de una estrofa
List<Widget> createListStanzas( item ) {
    List<Widget> listWidgets =  List<Widget>();
    listWidgets.add( Text( item.title, textAlign: TextAlign.center, style: TextStyle( color: Colors.blue[900], fontSize: Constant.sizeTitle, fontWeight: FontWeight.bold ) ) );
    listWidgets.add( SizedBox( height: 18.0 ) );

    for ( var item in item.stanzas ) {
      final stanzas = item['content'].split('-');
      final stanza = stanzas.map ( (stanza) {
        return stanza;
      }).join('\n');

      if ( item['title'] == 'CORO:') {
        final tempWidget = Column(
          children: <Widget>[
            Text( item['title'], style: TextStyle( color: Colors.blue[900], fontSize: Constant.sizeTitleStanza, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic ) ),
            Text( stanza, style: TextStyle( color: Colors.blue[900], fontSize: Constant.sizeStanza, fontStyle: FontStyle.italic ) ),
            SizedBox( height: 18.0 ),
          ],
        );
        listWidgets.add( tempWidget );
      } else {
        final tempWidget = Column(
          children: <Widget>[
            Text( item['title'], style: TextStyle( color: Colors.blue[900], fontSize: Constant.sizeTitleStanza, fontWeight: FontWeight.bold ) ),
            Text( stanza, style: TextStyle( fontSize: Constant.sizeStanza ) ),
            SizedBox( height: 18.0 ),
          ],
        );
        listWidgets.add( tempWidget );
      }  
    }

    return listWidgets;
  }

// Metodo para manejo de las acciones del appbar 
List<Widget> createActionAppBar( Function setState ) {
  return <Widget>[
          IconButton(
            icon: Icon( Icons.add_circle_outline, size: 30.0 ),
            onPressed: () {
              setState(() {
                if ( Constant.sizeTitle < 35.0 ) Constant.sizeTitle = Constant.sizeTitle + 2.0;
                if ( Constant.sizeTitleStanza < 33.0 ) Constant.sizeTitleStanza = Constant.sizeTitleStanza + 2.0;
                if ( Constant.sizeStanza < 31.0 ) Constant.sizeStanza = Constant.sizeStanza + 2.0;
              });
            },
          ),
          IconButton(
            icon: Icon( Icons.remove_circle_outline, size: 30.0 ),
            onPressed: () {
              setState(() {
                if ( Constant.sizeTitle > 13.0 ) Constant.sizeTitle = Constant.sizeTitle - 2.0;
                if ( Constant.sizeTitleStanza > 11.0 ) Constant.sizeTitleStanza = Constant.sizeTitleStanza - 2.0;
                if ( Constant.sizeStanza > 9.0 ) Constant.sizeStanza = Constant.sizeStanza - 2.0;
              });
            },
          ), 
          PopupMenuButton(
            onSelected: ( String choice ) {
              if ( choice == Constant.forDefault ) {
                setState(() {
                  Constant.sizeTitle = 23.0;
                  Constant.sizeTitleStanza = 21.0;
                  Constant.sizeStanza = 19.0;
                });
              } else {
                print('Reproducir Audio');
              }
            },
            icon: Icon( Icons.more_vert, size: 30.0 ),
            itemBuilder: ( BuildContext context) {
              return Constant.choices.map( (String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text( choice ),
                );
              }).toList();
            },
          )                
        ];
}

// Metodo para crear una lista de elementos
List<Widget> createListTabBarView( List<dynamic> listItems ) {
  return listItems.map( (item) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric( vertical: 50.0, horizontal: 25.0 ),
        child: Column( children: createListStanzas( item ) ),
      ),
    );
  }).toList();
}