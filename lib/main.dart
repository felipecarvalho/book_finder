// ignore_for_file: unused_local_variable
import 'package:book_finder/app.dart';
import 'package:book_finder/data/adapters/book_adapter.dart';
import 'package:book_finder/data/models/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(BookAdapter());

  final favoritesBox = await Hive.openBox<Book>('favorites');

  runApp(const App());
}
