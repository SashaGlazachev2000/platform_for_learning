class Lesson {
  Lesson({
    required this.title,
    required this.content,
  });
  final String title;
  final List<Content> content;
}

abstract class Content {
  Content({
    this.title = '',
    this.text = '',
  });
  final String title;
  final String text;
}

class Quiz extends Content {
  Quiz({
    super.title,
    required this.indexRightAnswer,
    required this.variants,
  });
  final int indexRightAnswer;
  final List<String> variants;
}

class TextContent extends Content {
  TextContent({super.text, super.title});
}
