import 'package:http/http.dart' as http;

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
}
