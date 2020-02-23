import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'repositories.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  InputValue createState() => InputValue();
}

class Service {
  final String endpoint = 'https://api.github.com/';
  Future<String> getUser(String user) {
    return http.get(endpoint + 'users/' + user).then((response) {
      return response.body;
    }).catchError((error) {
      return error;
    });
  }

  Future<String> getRepos(String user) {
    return http.get(endpoint + 'users/' + user + '/repos').then((response) {
      return response.body;
    }).catchError((error) {
      return error;
    });
  }

  void login(user, context) {
    try {
      getUser(user).then((response) async {
        var res = jsonDecode(response);
        if (res['message'] != null) {
          return showDialog(
              context: context,
              child: AlertDialog(
                content: Text('Usuário não encontrado'),
              ));
        } else {
          var repos = await getRepos(user);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Repositories(repos: repos)));
        }
      });
    } catch (error) {
      print(error);
    }
  }
}

class InputValue extends State<Login> {
  final inputControler = TextEditingController();
  final getUser = new Service();

  @override
  void dispose() {
    inputControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
        child: Container(
            color: Color.fromRGBO(70, 81, 99, 1),
            child: Directionality(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Bem-vindo',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                        Text(
                          'Para continuar insira seu usuário do GitHub',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Color.fromRGBO(255, 255, 255, 0.7)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: TextField(
                            controller: inputControler,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                hintText: 'Digite seu usuário'),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Material(
                            color: Color.fromRGBO(116, 150, 205, 1),
                            child: Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      Service()
                                          .login(inputControler.text, context);
                                    },
                                    child: Container(
                                      alignment: AlignmentDirectional.center,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 16),
                                      child: Text(
                                        'Continuar',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                ))));
  }
}
