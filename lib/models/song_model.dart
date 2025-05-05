class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String duration;
  final String imageUrl;
  final String youtubeUrl;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.duration,
    required this.imageUrl,
    required this.youtubeUrl,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      album: json['album'],
      duration: json['duration'],
      imageUrl: json['imageUrl'],
      youtubeUrl: json['youtubeUrl'],
    );
  }
}
