import 'package:mysql_manager/src/mysql_manager.dart';

class LeaderBoardsHandler {
  final MySQLManager manager = MySQLManager.instance;
  late final connection;

  LeaderBoardsHandler() {
    print("CONSTRUCTOR");
  }

  Future<String> init(
      {required String db,
      required String host,
      required String user,
      required String password,
      required int port}) async {
    print("INIT");
    connection = await manager.init(false, {
      'db': db,
      'host': host,
      'user': user,
      'password': password,
      'port': port
    });
    return 'OK';
  }

  void testConnection() async {
    print("TESTCONNECTION");
    print(connection.runtimeType);
    var res = await connection.execute('SELECT VERSION();');
    for (var row in res) {
      print(row);
    }
  }
}
