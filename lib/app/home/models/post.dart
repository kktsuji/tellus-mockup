class Post {
  Post({
    this.postId,
    this.title,
    this.speaker,
    this.description,
    this.url,
    this.img,
    this.fee,
  });

  final String postId;
  final String title;
  final String speaker;
  final String description;
  final String url;
  final int img;
  final int fee;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'title': title,
      'speaker': speaker,
      'description': description,
      'url': url,
      'img': img,
      'fee': fee,
    };
  }

  factory Post.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String title = data['title'];
    final String speaker = data['speaker'];
    final String description = data['description'];
    final String url = data['url'];
    final int img = data['img'];
    final int fee = data['fee'];
    return Post(
      title: title,
      speaker: speaker,
      description: description,
      url: url,
      img: img,
      fee: fee
    );
  }
}
