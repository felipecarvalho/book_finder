import 'package:book_finder/presentation/blocs/book_finder_bloc.dart';
import 'package:book_finder/presentation/screens/book_finder_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Book Finder',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.systemBlue,
      ),
      home: BlocProvider(
        create: (context) => BookFinderBloc(),
        child: BookFinderScreen(),
      ),
    );
  }
}
