import 'dart:collection';
import 'dart:io';
import 'Chapter.dart';

Future main() async {
  try {
    Future<String> futureData = new File('../data').readAsString();
    String data = await futureData;
    List<String> blocksChapter = data.trim().split("***");
    //remove empty block caused by the split
    blocksChapter.removeAt(0);
    HashMap<int, Chapter> hashmap = new HashMap();
    for (String stringChapter in blocksChapter) {
      Chapter chapter = new Chapter();
      List<String> chapterVector = stringChapter.split("-");
      //remove empty string caused by the split
      chapterVector.removeLast();
      String chapterInfo = chapterVector.removeAt(0);
      List<String> chapterInfoVector = chapterInfo.split(")");
      int number = int.parse(chapterInfoVector.first);
      String title = chapterInfoVector.last;
      chapter.number = number;
      chapter.title = title;
      chapter.questions = chapterVector;
      hashmap.putIfAbsent(number, () => chapter);
      hashmap.forEach((key, value) => print('${key},${chapter.questions}'));
    }
  } catch (e) {
    print(e);
  }
  var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 4042);
  print('Listening on localhost:${server.port}');

  await for (HttpRequest request in server) {
    request.response.write('Hello, world!');
    await request.response.close();
  }
}
