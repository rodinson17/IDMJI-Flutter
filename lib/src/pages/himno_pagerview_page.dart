import 'package:flutter/material.dart';
import 'package:idmji/src/bloc/data_bloc.dart';
import 'package:idmji/src/models/himno_model.dart';
import 'package:idmji/src/utils/utils.dart' as utils;
//import 'package:flute_music_player/flute_music_player.dart';

class HimnoPagerView extends StatefulWidget {

  @override
  _HimnoPagerViewState createState() => _HimnoPagerViewState();
}

class _HimnoPagerViewState extends State<HimnoPagerView> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  final corosBloc = DataBloc();
  List<Himno> _listHimnos = List();
  int indexTab = -1;

  @override
  void initState() {
    super.initState();
    _listHimnos = corosBloc.getListHimnos();
    _tabController = TabController( vsync: this, length: _listHimnos.length );
    _scrollController = ScrollController( initialScrollOffset: 0.0 );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build( BuildContext context ) {
    final Himno himno = ModalRoute.of( context ).settings.arguments;
    //_tabController.animateTo( (himno.id - 1), curve: Curves.bounceInOut, duration: Duration( milliseconds: 10) );
    indexTab = _tabController.index;

    setState(() {
      if (indexTab == 0 ) indexTab = indexTab = (himno.id - 1);
      _tabController.animateTo( indexTab );
    });

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: ( BuildContext context, bool boxIsScrolled ) {
          return <Widget>[
            SliverAppBar(
              title: Text( 'Himnos', style: TextStyle( fontSize: 22.0 ) ),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                isScrollable: true,
                controller: _tabController,
                tabs: _listHimnos.map( (himno) => Tab( child: Text( 'HIMNO ${ himno.id }', style: TextStyle( fontSize: 16.0 ) ) )).toList(),
              ),
              actions: utils.createActionAppBar( setState ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: utils.createListTabBarView( _listHimnos ), 
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.apps ),
        onPressed: () => _showListCorosAlert( context )
      ),
    );
  }

  void _showListCorosAlert( BuildContext context ){    
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: ( context ) {
        return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular( 10.0 ) ),
          title: Text( 'Himnos' ),
          contentPadding: EdgeInsets.all( 20.0 ),
          content: _createContentAlert(),
          actions: <Widget>[
            FlatButton(
              child: Text( 'Cancelar', style: TextStyle( fontSize: 18.0 ) ),
              onPressed: () => Navigator.of( context ).pop()
            ),
          ],
        );
      }
    );  
  }

  Widget _createContentAlert() {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _createItems()
        ),
      ),
    );
  }

  List<Widget> _createItems() {
    List<Widget> listWidgets =  List<Widget>();
    List<Widget> listItems = List<Widget>();
    int i = 0;
    final cant = _listHimnos.last;

    for ( var item in _listHimnos ) {
      i++;
      final btn = FlatButton( child: Text( item.id.toString(), style: TextStyle( fontSize: 18.0 ) ), 
                              color: Colors.blue[300], 
                              textColor: Colors.black54,
                              onPressed: () => _actionButtonSelect( item.id ) );
      if ( i < 3 ){
        listItems.add( btn );
        listItems.add( SizedBox( width: 12.0 ) );
      } 
      if ( i == 3 ) {
        listItems.add( btn );
        listWidgets.add( Row( children: listItems ) );
        listItems = List<Widget>();
        i = 0;
      }

      if ( item.id == cant.id ) listWidgets.add( Row( children: listItems ) );
    }

    return listWidgets;
  }

  void _actionButtonSelect( select ) {
    _tabController.animateTo( select - 1 );
    Navigator.of( context ).pop();
  }
}
