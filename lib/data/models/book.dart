class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String description;
  final String? buyLink;
  final bool favorite;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.description,
    this.buyLink,
    this.favorite = false,
  });

  Book copyWith({
    String? id,
    String? title,
    List<String>? authors,
    String? description,
    String? buyLink,
    bool? favorite,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      description: description ?? this.description,
      buyLink: buyLink ?? this.buyLink,
      favorite: favorite ?? this.favorite,
    );
  }
}
