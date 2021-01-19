import 'package:flutter/material.dart';

class NestedPage extends StatefulWidget {
  @override
  _NestedPageState createState() => _NestedPageState();
}

class _NestedPageState extends State<NestedPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  final _listExample = ['uno', 'dos', 'tres', 'cuatro', 'cinco', 'seis', 'siete', 'ocho', 'nueve', 'diez'];

  @override
  void initState() {
    super.initState();
    //_tabController = TabController( vsync: this, length: 2 );
    _tabController = TabController( vsync: this, length: _listExample.length );
    _scrollController = ScrollController( initialScrollOffset: 0.0 );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: ( BuildContext context, bool boxIsScrolled ) {
          return <Widget>[
            SliverAppBar(
              title: Text('Tab controller Example'),
              pinned: true,
              floating: true,
              forceElevated: boxIsScrolled,
              bottom: TabBar(
                isScrollable: true,
                controller: _tabController,
                tabs: _listExample.map( (text) => Tab( 
                    child: Container( child: Text( text )) )
                  ).toList(),
                /* tabs: <Widget>[
                  Tab(
                    text: 'Home',
                    icon: Icon( Icons.home ),
                  ),
                  Tab(
                    text: 'Example page',
                    icon: Icon( Icons.help ),
                  )
                ], */
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: _listItems()
          
          /* children: <Widget>[
            PageOne(),
            PageTwo()
          ], */
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.control_point ),
        onPressed: () {
          _tabController.animateTo(0, curve: Curves.bounceInOut, duration: Duration( milliseconds: 10) );
          _scrollController.jumpTo( _scrollController.position.maxScrollExtent );
        },
      ),
    );
  } 

  List<Widget> _listItems() {
    return _listExample.map( (text) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(text)
          ],
        ),
      );
    }).toList();
  }
}

class PageOne extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/logo_idmji.png',
            width: 200.0,
          )
        ],
      ),
    );
  }
}

class PageTwo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 250.0,
      itemBuilder: ( context, index ) => Container(
        padding: EdgeInsets.all( 10.0 ),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular( 5.0 ),
          color: index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
          child: Center(
            child: Text( index.toString() ),
          ),
        ),
      ),
    );
  }
}