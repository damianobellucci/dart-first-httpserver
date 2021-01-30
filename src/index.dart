import 'dart:collection';
import 'dart:io';
import 'dart:math';
import './lib/parseText.dart';
import './lib/Chapter.dart';

Future main() async {
  //parsing data for responses
  HashMap<int, Chapter> dataHashMap = new HashMap();
  dataHashMap.addAll(await parseText());

  //init server
  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 4042);
  print('Listening on localhost:${server.port}');

  //serving responses
  await for (HttpRequest request in server) {
    Chapter chapter = dataHashMap[new Random().nextInt(dataHashMap.length)];
    String question =
        chapter.questions[new Random().nextInt(chapter.questions.length)];
    request.response.write(question);
    await request.response.close();
  }
}
