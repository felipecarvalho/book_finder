import 'package:book_finder/data/models/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:book_finder/presentation/blocs/book_finder_bloc.dart';
import 'package:book_finder/presentation/screens/book_finder_screen.dart';

void main() {
  group('BookFinderScreen', () {
    late BookFinderBloc bookFinderBloc;

    setUp(() {
      bookFinderBloc = BookFinderBloc();
    });

    tearDown(() {
      bookFinderBloc.close();
    });

    testWidgets('should display loading indicator when state is BookFinderLoading', (WidgetTester tester) async {
      bookFinderBloc.emit(BookFinderLoading());

      await tester.pumpWidget(
        CupertinoApp(
          home: BlocProvider<BookFinderBloc>.value(
            value: bookFinderBloc,
            child: BookFinderScreen(),
          ),
        ),
      );

      expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
    });

    testWidgets('should display book list when state is BookFinderSuccess', (WidgetTester tester) async {
      final books = [
        Book(
          id: '1',
          title: 'Book 1',
          authors: ['Author 1'],
          description: 'Description 1',
          favorite: false,
        ),
        Book(
          id: '2',
          title: 'Book 2',
          authors: ['Author 2'],
          description: 'Description 2',
          favorite: true,
        ),
      ];
      bookFinderBloc.emit(BookFinderSuccess(books));

      await tester.pumpWidget(
        CupertinoApp(
          home: BlocProvider<BookFinderBloc>.value(
            value: bookFinderBloc,
            child: BookFinderScreen(),
          ),
        ),
      );

      expect(find.text('Book 1'), findsOneWidget);
      expect(find.text('Author 1'), findsOneWidget);
      expect(find.text('Book 2'), findsOneWidget);
      expect(find.text('Author 2'), findsOneWidget);
    });

    testWidgets('should display error message when state is BookFinderError', (WidgetTester tester) async {
      bookFinderBloc.emit(BookFinderError('Failed to load books'));

      await tester.pumpWidget(
        CupertinoApp(
          home: BlocProvider<BookFinderBloc>.value(
            value: bookFinderBloc,
            child: BookFinderScreen(),
          ),
        ),
      );

      expect(find.text('Failed to load books'), findsOneWidget);
    });
  });
}
