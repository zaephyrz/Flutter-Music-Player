import 'song_model.dart'; // Add this at the top of the file

class Playlist {
  final String id;
  final String name;
  final String description;
  final String coverImage;
  final List<Song> songs;

  Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.coverImage,
    required this.songs,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      coverImage: json['coverImage'],
      songs: (json['songs'] as List).map((e) => Song.fromJson(e)).toList(),
    );
  }
}
