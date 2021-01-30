import 'dart:collection';
import 'dart:io';
import 'Chapter.dart';

Future<HashMap<int, Chapter>> parseText() async {
  try {
    Future<String> futureData = new File('../data').readAsString();
    String data = await futureData;
    List<String> blocksChapter = data.trim().split("***");
    //remove empty block caused by the split
    blocksChapter.removeAt(0);
    HashMap<int, Chapter> hashmap = new HashMap();

    int indexHashMap = 0;

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
      hashmap.putIfAbsent(indexHashMap, () => chapter);
      indexHashMap++;
      //hashmap.forEach((key, value) => print('${key},${chapter.questions}'));
    }
    return hashmap;
  } catch (e) {
    print(e);
  }
}
