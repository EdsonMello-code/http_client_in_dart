import 'package:dio/dio.dart';

var todoOfUser;
void main() async {
  final repository = Repository();
  await repository.getTodoOfUser();
  print(repository.todoOfUser);
}

class Repository {
  String? _error;
  dynamic todoOfUser;

  getTodoOfUser() async {
    try {
      todoOfUser = await ClientHttp(dio: Dio()).get();
    } on DioError catch (e) {
      _error = e.message;
    } finally {
      if (_error != null) {
        print(_error);
      }
    }
  }
}

abstract class IHttpClient {
  Future<Response<dynamic>> get();
}

class ClientHttp implements IHttpClient {
  final Dio dio;

  ClientHttp({required this.dio});
  @override
  Future<Response> get() =>
      dio.get('https://jsonplaceholder.typicode.com/todos/1');
}
