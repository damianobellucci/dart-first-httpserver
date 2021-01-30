class Chapter {
  int _number;
  String _title;
  List<String> _questions;

  set number(int value) => _number = value;
  set title(String title) => _title = title;
  set questions(List<String> questions) => _questions = questions;

  int get number => _number;
  String get title => _title;
  List<String> get questions => _questions;
}
