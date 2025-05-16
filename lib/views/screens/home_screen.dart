import 'package:flutter/material.dart';
import '../../controllers/music_controller.dart';
import '../../utilities/routes.dart';
import '../widgets/gradient_appbar.dart';
import '../widgets/music_card.dart';
import '../widgets/playlist_card.dart';

class HomeScreen extends StatelessWidget {
  final MusicController _musicController = MusicController();

  HomeScreen({
    super.key,
    required MusicController musicController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: 'Music Player',
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Recently Played',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _musicController.songs.length,
                itemBuilder: (context, index) {
                  final song = _musicController.songs[index];
                  return SizedBox(
                    width: 180,
                    child: MusicCard(
                      song: song,
                      onTap: () => _musicController.playSong(song),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Your Playlists',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemCount: _musicController.playlists.length,
              itemBuilder: (context, index) {
                final playlist = _musicController.playlists[index];
                return PlaylistCard(
                  playlist: playlist,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.playlist,
                      arguments: playlist,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
