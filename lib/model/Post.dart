class Post {
  final int id;
  final String title;
  final String authorimage;
  final String authorname;
  final String excerpt;
  final String date;
  final String content;
  final String image;
  final String link;
  bool isSaved = false;

  Post(
    {
      this.content,
      this.id,
      this.title,
      this.excerpt,
      this.date,
      this.image,
      this.authorimage,
      this.authorname,
      this.link
    }
  );

  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title']['rendered'],
      content: json['content']['rendered'],
      date: json['date'] != null
        ? json['date'].toString().replaceFirst('T', ' ')
        : null,
      image: json['_embedded']['wp:featuredmedia'][0]['source_url'] != null
        ? json['_embedded']['wp:featuredmedia'][0]['source_url']
        : null,
      excerpt: json['excerpt']['rendered'],
      authorimage: json['_embedded']['author'][0]['avatar_urls']['96'],
      authorname: json['_embedded']['author'][0]['name'].toString(),
      link: json['link']
    );
  }
}