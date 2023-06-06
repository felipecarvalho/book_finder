import 'package:book_finder/data/models/book.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookAdapter extends TypeAdapter<Book> {
  @override
  final int typeId = 0;

  @override
  Book read(BinaryReader reader) {
    final fields = reader.readMap();
    return Book(
      id: fields['id'] as String,
      title: fields['title'] as String,
      authors: (fields['authors'] as List<dynamic>).cast<String>(),
      description: fields['description'] as String,
      buyLink: fields['buyLink'] as String?,
      favorite: fields['favorite'] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer.writeMap({
      'id': obj.id,
      'title': obj.title,
      'authors': obj.authors,
      'description': obj.description,
      'buyLink': obj.buyLink,
      'favorite': obj.favorite,
    });
  }
}
