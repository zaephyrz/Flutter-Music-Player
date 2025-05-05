import 'package:flutter/material.dart';
import '../../config/colors.dart';
import '../../models/song_model.dart';

class SongTile extends StatelessWidget {
  final Song song;
  final VoidCallback onTap;
  final VoidCallback? onAddToPlaylist;

  const SongTile({
    required this.song,
    required this.onTap,
    this.onAddToPlaylist,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          song.imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        song.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(song.artist),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(song.duration),
          if (onAddToPlaylist != null) ...[
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(Icons.playlist_add, color: AppColors.primaryColor),
              onPressed: onAddToPlaylist,
            ),
          ],
        ],
      ),
      onTap: onTap,
    );
  }
}
