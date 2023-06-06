import 'package:book_finder/data/models/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  const BookDetailsScreen({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(book.title),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Autor', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text(book.authors.join(', ')),
                      const SizedBox(height: 24),
                      const Text('Descrição', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text(book.description),
                    ],
                  ),
                ),
              ),
            ),
            if (book.buyLink != null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: CupertinoButton.filled(
                  onPressed: () {
                    Uri url = Uri.parse(book.buyLink!);
                    launchUrl(url);
                  },
                  child: const Text('Comprar'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
