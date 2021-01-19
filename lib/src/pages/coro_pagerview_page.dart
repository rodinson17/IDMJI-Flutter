import 'package:flutter/material.dart';
import 'package:idmji/src/bloc/data_bloc.dart';
import 'package:idmji/src/models/coro_model.dart';
import 'package:idmji/src/utils/utils.dart' as utils;

class CoroPagerView extends StatefulWidget {

  @override
  _CoroPagerViewState createState() => _CoroPagerViewState();
}

class _CoroPagerViewState extends State<CoroPagerView> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  final corosBloc = DataBloc();
  List<Coro> _listCoros = List();
  int indexTab = 0;

  @override
  void initState() {
    super.initState();
    _listCoros = corosBloc.getListCoros();
    _tabController = TabController( vsync: this, length: _listCoros.length );
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
    final Coro coro = ModalRoute.of( context ).settings.arguments;
    indexTab = _tabController.index;
    
    setState(() {
      if (indexTab == 0 ) indexTab = indexTab = (coro.id - 1);
      //_tabController.animateTo( indexTab, curve: Curves.bounceInOut, duration: Duration( milliseconds: 10) );   
      _tabController.animateTo( indexTab );   
    });

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: ( BuildContext context, bool boxIsScrolled ) {
          return <Widget>[
            SliverAppBar(
              title: Text( 'Coros', style: TextStyle( fontSize: 22.0 ) ),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                isScrollable: true,
                controller: _tabController,
                tabs: _listCoros.map( (coro) => Tab( child: Text( 'CORO ${ coro.id }', style: TextStyle( fontSize: 16.0 ) ) )).toList(),
              ),
              actions: utils.createActionAppBar( setState ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: utils.createListTabBarView( _listCoros ),
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
          title: Text( 'Coros' ),
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
    final cant = _listCoros.last;

    for ( var item in _listCoros ) {
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
