import 'package:flutter/material.dart';
import 'config/colors.dart';
import 'utilities/routes.dart';
import 'controllers/music_controller.dart';

void main() {
  // Initialize the music controller once
  final musicController = MusicController();

  runApp(MyApp(musicController: musicController));
}

class MyApp extends StatelessWidget {
  final MusicController musicController;

  const MyApp({super.key, required this.musicController});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      theme: AppColors.theme,
      initialRoute: AppRoutes.login,
      onGenerateRoute:
          (settings) => AppRoutes.generateRoute(settings, musicController),
      debugShowCheckedModeBanner: false,
    );
  }
}
