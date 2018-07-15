import 'package:cinemacast/ui/colors.dart';
import 'package:flutter/material.dart';

final ThemeData themeCinemaCast = _buildThemeCinemaCast();

ThemeData _buildThemeCinemaCast() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    primaryColor: almostBlack,
    accentColor: yellow,
  );
}