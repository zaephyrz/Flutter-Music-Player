//import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_music_player/main.dart';
import 'package:simple_music_player/controllers/music_controller.dart';
import 'package:simple_music_player/views/screens/login_screen.dart';
import 'package:simple_music_player/views/screens/register_screen.dart';

void main() {
  group('App Widget Tests', () {
    late MusicController musicController;

    setUp(() {
      musicController = MusicController();
    });

    testWidgets('App starts with LoginScreen', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp(musicController: musicController));
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('Navigation to RegisterScreen works', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(MyApp(musicController: musicController));

      // Tap the register button (assuming you have one)
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.byType(RegisterScreen), findsOneWidget);
    });
  });
}
