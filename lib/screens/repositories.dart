import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

class Repositories extends StatefulWidget {
  final String user;
  Repositories({Key key, @required this.user}) : super(key: key);

  @override
  RepositoriesState createState() => RepositoriesState();
}

class RepositoriesState extends State<Repositories> {
  List<dynamic> repos = [];
  //props
  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    new Service().getRepos(widget.user).then((response) => setState(() {
          repos = jsonDecode(response);
        }));
  }

  @override
  Widget build(BuildContext context) {
    Widget loading() {
      if (repos.length == 0) {
        return Theme(
            data: ThemeData(accentColor: Color.fromRGBO(116, 150, 205, 1)),
            child: Center(
                child: CircularProgressIndicator(
              strokeWidth: 4,
            )));
      } else {
        return ListView.builder(
          itemCount: repos.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 80,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.all(16),
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      repos[index]['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.solidStar,
                          size: 12,
                          color: Colors.black,
                        ),
                        Padding(padding: EdgeInsets.only(right: 4)),
                        Text(
                          repos[index]["stargazers_count"].toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        FaIcon(
                          FontAwesomeIcons.codeBranch,
                          size: 12,
                          color: Colors.black,
                        ),
                        Padding(padding: EdgeInsets.only(right: 4)),
                        Text(
                          repos[index]["stargazers_count"].toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        FaIcon(
                          FontAwesomeIcons.eye,
                          size: 12,
                          color: Colors.black,
                        ),
                        Padding(padding: EdgeInsets.only(right: 4)),
                        Text(
                          repos[index]["stargazers_count"].toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ));
          },
          padding: const EdgeInsets.all(10),
        );
      }
    }

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
              'Repositórios',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            backgroundColor: Colors.white,
          ),
          body: Container(color: Colors.grey[200], child: loading()),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color.fromRGBO(70, 81, 99, 1),
            unselectedItemColor: Colors.grey[400],
            selectedItemColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.listAlt,
                    size: 20,
                  ),
                  title: Text('Repositórios')),
              BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.building,
                    size: 20,
                  ),
                  title: Text('Organizações')),
            ],
            currentIndex: 0,
          ),
        ),
      ),
    );
  }
}
