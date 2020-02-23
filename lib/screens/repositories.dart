import 'package:flutter/material.dart';

class Repositories extends StatelessWidget {
  //props
  final String repos;
  Repositories({Key key, this.repos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          appBar: AppBar(
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 1,
            title: Text(
              'Repositories',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
          body: ListView(
            padding: const EdgeInsets.all(10),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color.fromRGBO(70, 81, 99, 1),
            unselectedItemColor: Colors.grey[400],
            selectedItemColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Repositories')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.business), title: Text('Organizations')),
            ],
            currentIndex: 0,
          ),
        ),
      ),
    );
  }
}
