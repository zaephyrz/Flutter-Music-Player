import '../models/song_model.dart';
import '../models/playlist_model.dart';

class MusicController {
  List<Playlist> playlists = [
    Playlist(
      id: '1',
      name: 'Favorites',
      description: 'My favorite songs',
      coverImage: 'https://i.ytimg.com/vi/4NRXx6U8ABQ/maxresdefault.jpg',
      songs: [
        Song(
          id: '1',
          title: 'Blinding Lights',
          artist: 'The Weeknd',
          album: 'After Hours',
          duration: '3:20',
          imageUrl: 'https://i.ytimg.com/vi/4NRXx6U8ABQ/maxresdefault.jpg',
          youtubeUrl: 'https://www.youtube.com/watch?v=4NRXx6U8ABQ',
        ),
        Song(
          id: '2',
          title: 'Save Your Tears',
          artist: 'The Weeknd',
          album: 'After Hours',
          duration: '3:35',
          imageUrl: 'https://i.ytimg.com/vi/XXYlFuWEuKI/maxresdefault.jpg',
          youtubeUrl: 'https://www.youtube.com/watch?v=XXYlFuWEuKI',
        ),
      ],
    ),
  ];

  final List<Song> songs = [
    Song(
      id: '1',
      title: 'Blinding Lights',
      artist: 'The Weeknd',
      album: 'After Hours',
      duration: '3:20',
      imageUrl: 'https://i.ytimg.com/vi/4NRXx6U8ABQ/maxresdefault.jpg',
      youtubeUrl: 'https://www.youtube.com/watch?v=4NRXx6U8ABQ',
    ),
    Song(
      id: '2',
      title: 'Save Your Tears',
      artist: 'The Weeknd',
      album: 'After Hours',
      duration: '3:35',
      imageUrl: 'https://i.ytimg.com/vi/XXYlFuWEuKI/maxresdefault.jpg',
      youtubeUrl: 'https://www.youtube.com/watch?v=XXYlFuWEuKI',
    ),
    Song(
      id: '3',
      title: 'Stay',
      artist: 'The Kid LAROI, Justin Bieber',
      album: 'F*CK LOVE 3: OVER YOU',
      duration: '2:21',
      imageUrl: 'https://i.ytimg.com/vi/kTJczUoc26U/maxresdefault.jpg',
      youtubeUrl: 'https://www.youtube.com/watch?v=kTJczUoc26U',
    ),
  ];

  void playSong(Song song) {
    print('Playing: ${song.title} from YouTube: ${song.youtubeUrl}');
  }

  void addToPlaylist(String playlistId, Song song) {
    final playlist = playlists.firstWhere((p) => p.id == playlistId);
    playlist.songs.add(song);
  }

  void addPlaylist(Playlist playlist) {
    playlists.add(playlist);
  }

  void removePlaylist(String playlistId) {
    playlists.removeWhere((playlist) => playlist.id == playlistId);
  }
}
