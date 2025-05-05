import 'package:flutter/material.dart';
import '../../controllers/music_controller.dart';
import '../../models/playlist_model.dart';
import '../widgets/gradient_appbar.dart';
import '../widgets/song_tile.dart';
import '../widgets/playlist_card.dart';

class PlaylistScreen extends StatefulWidget {
  final Playlist? playlist;
  final MusicController musicController;

  const PlaylistScreen({
    super.key,
    this.playlist,
    required this.musicController,
  });

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final TextEditingController _playlistNameController = TextEditingController();
  final TextEditingController _playlistDescController = TextEditingController();

  @override
  void dispose() {
    _playlistNameController.dispose();
    _playlistDescController.dispose();
    super.dispose();
  }

  void _showAddPlaylistDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Create New Playlist'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _playlistNameController,
                  decoration: const InputDecoration(labelText: 'Playlist Name'),
                ),
                TextField(
                  controller: _playlistDescController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_playlistNameController.text.isNotEmpty) {
                    final newPlaylist = Playlist(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: _playlistNameController.text,
                      description: _playlistDescController.text,
                      coverImage: 'https://via.placeholder.com/150',
                      songs: [],
                    );
                    widget.musicController.addPlaylist(newPlaylist);
                    setState(() {
                      _playlistNameController.clear();
                      _playlistDescController.clear();
                    });
                    Navigator.pop(context);
                  }
                },
                child: const Text('Create'),
              ),
            ],
          ),
    );
  }

  void _deletePlaylist(String playlistId) {
    setState(() {
      widget.musicController.removePlaylist(playlistId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.playlist != null) {
      return _buildPlaylistDetailView(widget.playlist!);
    }

    return Scaffold(
      appBar: GradientAppBar(
        title: 'Your Playlists',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddPlaylistDialog(context),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: widget.musicController.playlists.length,
        itemBuilder: (context, index) {
          final playlist = widget.musicController.playlists[index];
          return Dismissible(
            key: Key(playlist.id),
            background: Container(color: Colors.red),
            onDismissed: (_) => _deletePlaylist(playlist.id),
            child: PlaylistCard(
              playlist: playlist,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => PlaylistScreen(
                          playlist: playlist,
                          musicController: widget.musicController,
                        ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlaylistDetailView(Playlist playlist) {
    return Scaffold(
      appBar: GradientAppBar(
        title: playlist.name,
        actions: [
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () {
              if (playlist.songs.isNotEmpty) {
                widget.musicController.playSong(playlist.songs.first);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deletePlaylist(playlist.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    playlist.coverImage,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        playlist.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        playlist.description,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${playlist.songs.length} songs',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: playlist.songs.length,
              itemBuilder: (context, index) {
                final song = playlist.songs[index];
                return SongTile(
                  song: song,
                  onTap: () => widget.musicController.playSong(song),
                  onAddToPlaylist: () {
                    // Show dialog to add to other playlists
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
