import 'package:demos_app/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';

Future <void> main() async{
   await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: IntroScreen(),
  ));
}
