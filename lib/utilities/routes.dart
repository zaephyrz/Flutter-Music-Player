import 'package:flutter/material.dart';
import '../controllers/music_controller.dart';
import '../models/playlist_model.dart';
import '../views/screens/main_screen.dart';
import '../views/screens/login_screen.dart';
import '../views/screens/playlist_screen.dart';
import '../views/screens/register_screen.dart';

class AppRoutes {
  static const String main = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String playlist = '/playlist';

  static Route<dynamic> generateRoute(
    RouteSettings settings,
    MusicController musicController,
  ) {
    switch (settings.name) {
      case main:
        return MaterialPageRoute(
          builder: (_) => MainScreen(musicController: musicController),
        );
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case playlist:
        final args = settings.arguments as Playlist?;
        return MaterialPageRoute(
          builder:
              (_) => PlaylistScreen(
                playlist: args,
                musicController: musicController,
              ),
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
