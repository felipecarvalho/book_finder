import 'dart:async';
import 'dart:convert';
import 'package:book_finder/data/models/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class BookFinderBloc extends Cubit<BookFinderState> {
  BookFinderBloc() : super(BookFinderInitial());

  Future<void> searchBooks(String keyword) async {
    try {
      emit(BookFinderLoading());

      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        final favoritesBox = await Hive.openBox<Book>('favorites');
        final favoriteBooks = favoritesBox.values.cast<Book>().toList();
        emit(BookFinderSuccess(favoriteBooks));
      } else if (keyword.isNotEmpty) {
        final response = await http.get(
          Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': keyword}),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final items = data['items'];

          final favoritesBox = await Hive.openBox<Book>('favorites');
          final favoriteBooks = favoritesBox.values.cast<Book>().toList();

          final books = items.map<Book>((item) {
            final volumeInfo = item['volumeInfo'];
            final saleInfo = item['saleInfo'];

            final isFavorite = favoriteBooks.any((favoriteBook) => favoriteBook.id == item['id']);

            return Book(
              id: item['id'],
              title: volumeInfo['title'],
              authors: volumeInfo['authors'] != null ? List<String>.from(volumeInfo['authors']) : [],
              description: volumeInfo['description'] ?? '',
              buyLink: saleInfo['buyLink'],
              favorite: isFavorite,
            );
          }).toList();

          emit(BookFinderSuccess(books));
        } else {
          emit(BookFinderError('Erro ao carregar as informações do livro. Tente novamente.'));
        }
      } else {
        final favoritesBox = await Hive.openBox<Book>('favorites');
        final favoriteBooks = favoritesBox.values.cast<Book>().toList();
        emit(BookFinderSuccess(favoriteBooks));
      }
    } catch (e) {
      emit(BookFinderError('Ocorreu um erro. Tente novamente.'));
    }
  }

  void toggleFavorite(Book book) async {
    final isFavorite = book.favorite;
    final updatedBook = book.copyWith(favorite: !isFavorite);

    final favoritesBox = Hive.box<Book>('favorites');
    if (updatedBook.favorite) {
      await favoritesBox.put(updatedBook.id, updatedBook);
    } else {
      await favoritesBox.delete(updatedBook.id);
    }

    final currentBooks = (state as BookFinderSuccess).books;
    final updatedBooks = currentBooks.map((b) => b.id == book.id ? updatedBook : b).toList();
    emit(BookFinderSuccess(updatedBooks));
  }
}

abstract class BookFinderState {}

class BookFinderInitial extends BookFinderState {}

class BookFinderLoading extends BookFinderState {}

class BookFinderSuccess extends BookFinderState {
  final List<Book> books;

  BookFinderSuccess(this.books);
}

class BookFinderError extends BookFinderState {
  final String error;

  BookFinderError(this.error);
}
