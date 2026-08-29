import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Background & Surfaces (Deep Charcoal & Dark Slate)
  static const Color background = Color(0xFF141318);
  static const Color scaffoldColor = Color(0xFF141318);
  static const Color surface = Color(0xFF1E1C27);
  static const Color surfaceElevated = Color(0xFF262334);
  static const Color card = Color(0xFF22202E);
  static const Color popover = Color(0xFF242131);

  // Foregrounds / Text Colors
  static const Color foreground = Color(0xFFF7F6F9);
  static const Color cardForeground = Color(0xFFF7F6F9);
  static const Color textPrimary = Color(0xFFF7F6F9);
  static const Color textSecondary = Color(0xFF9E99AB);
  static const Color mutedForeground = Color(0xFF9E99AB);
  static const Color textDisabled = Color(0xFF686475);

  // Primary & Accents (Electric Violet & Indigo)
  static const Color primary = Color(0xFF9E63F8);
  static const Color primaryLight = Color(0xFFB584FA);
  static const Color primaryDark = Color(0xFF7E3AED);
  static const Color primaryForeground = Color(0xFF130E1F);

  // Secondary & Muted
  static const Color secondary = Color(0xFF2F2C3D);
  static const Color secondaryForeground = Color(0xFFF7F6F9);
  static const Color muted = Color(0xFF2B2838);

  // Accents, Status & Borders
  static const Color accent = Color(0xFF38BDF8); // Cyan
  static const Color accentForeground = Color(0xFF130E1F);
  static const Color success = Color(0xFF22C55E); // Emerald Green
  static const Color destructive = Color(0xFFEF4444); // Red
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color border = Color(0xFF383448);
  static const Color input = Color(0xFF272436);
  static const Color inputBorder = Color(0xFF383448);
  static const Color ring = Color(0xFF9E63F8);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF9E63F8),
      Color(0xFF6E56CF),
    ],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF282438),
      Color(0xFF1C1A27),
    ],
  );

  static const RadialGradient heroGradient = RadialGradient(
    center: Alignment.topCenter,
    radius: 1.0,
    colors: [
      Color(0x669E63F8),
      Color(0xFF141318),
    ],
  );

  // Shadows
  static const List<BoxShadow> primaryGlow = [
    BoxShadow(
      color: Color(0x559E63F8),
      blurRadius: 24,
      offset: Offset(0, 8),
      spreadRadius: -4,
    ),
  ];

  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x66000000),
      blurRadius: 20,
      offset: Offset(0, 6),
      spreadRadius: -4,
    ),
  ];

  // Document (Light Mode Resume Canvas)
  static const Color docBackground = Color(0xFFFFFFFF);
  static const Color docTextPrimary = Color(0xFF111111);
  static const Color docTextSecondary = Color(0xFF444444);
  static const Color docTextMuted = Color(0xFF666666);
  static const Color docAccent = Color(0xFF6E56CF);
  static const Color docSkillBg = Color(0xFFF0ECFF);
  static const Color docSkillText = Color(0xFF4C3AA5);
}
