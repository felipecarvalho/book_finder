// ignore_for_file: must_be_immutable
import 'dart:async';
import 'package:book_finder/data/models/book.dart';
import 'package:book_finder/presentation/blocs/book_finder_bloc.dart';
import 'package:book_finder/presentation/screens/book_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BookFinderScreen extends StatelessWidget {
  String searchKeyword = '';
  Timer? searchTimer;
  TextEditingController searchText = TextEditingController();

  BookFinderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Book Finder'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: CupertinoTextField(
                controller: searchText,
                onChanged: (value) {
                  if (searchTimer != null) {
                    searchTimer!.cancel();
                  }

                  searchTimer = Timer(const Duration(milliseconds: 500), () {
                    context.read<BookFinderBloc>().searchBooks(value);
                    searchTimer = null;
                  });

                  searchKeyword = value;
                },
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    CupertinoIcons.search,
                    size: 22,
                    color: CupertinoColors.inactiveGray,
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<BookFinderBloc, BookFinderState>(
                builder: (context, state) {
                  if (state is BookFinderLoading) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  } else if (state is BookFinderSuccess) {
                    return ListView.builder(
                      itemCount: state.books.length,
                      itemBuilder: (context, index) {
                        final book = state.books[index];
                        return CupertinoListTile(
                          title: Text(book.title),
                          subtitle: Text(book.authors.join(', ')),
                          trailing: CupertinoButton(
                            child: Icon(
                              book.favorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                              color: CupertinoColors.systemRed,
                            ),
                            onPressed: () {
                              context.read<BookFinderBloc>().toggleFavorite(book);
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => BookDetailsScreen(book: book),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is BookFinderError) {
                    return Center(
                      child: Text(state.error),
                    );
                  } else {
                    final favoritesBox = Hive.box<Book>('favorites');
                    final favoriteBooks = favoritesBox.values.cast<Book>().toList();
                    return ListView.builder(
                      itemCount: favoriteBooks.length,
                      itemBuilder: (context, index) {
                        final book = favoriteBooks[index];
                        return CupertinoListTile(
                          title: Text(book.title),
                          subtitle: Text(book.authors.join(', ')),
                          trailing: CupertinoButton(
                            child: Icon(
                              book.favorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                              color: CupertinoColors.systemRed,
                            ),
                            onPressed: () {
                              context.read<BookFinderBloc>().toggleFavorite(book);
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => BookDetailsScreen(book: book),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
