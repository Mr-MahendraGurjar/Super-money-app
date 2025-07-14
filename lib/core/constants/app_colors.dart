import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Modern Blue
  static const Color primaryDark = Color(0xFF0052CC);
  static const Color primary = Color(0xFF0066FF);
  static const Color primaryLight = Color(0xFF4D94FF);
  
  // Accent Colors - Fresh Teal
  static const Color accent = Color(0xFF00D9FF);
  static const Color accentLight = Color(0xFF66E5FF);
  
  // Background Colors - Clean & Minimal
  static const Color background = Color(0xFFF7F9FC);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF0F4F8);
  
  // Text Colors - High Contrast
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textLight = Color(0xFF94A3B8);
  
  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);
  
  // Transaction Colors
  static const Color sendMoney = Color(0xFFEF4444);
  static const Color receiveMoney = Color(0xFF10B981);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0066FF),
      Color(0xFF0052CC),
    ],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0066FF),
      Color(0xFF0052CC),
    ],
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF00D9FF),
      Color(0xFF00B8E6),
    ],
  );
  
  // Shadows - Subtle and Modern
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: const Color(0xFF0F172A).withValues(alpha: 0.04),
      offset: const Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: const Color(0xFF0F172A).withValues(alpha: 0.06),
      offset: const Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: primary.withValues(alpha: 0.25),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];
  
  static List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: const Color(0xFF0F172A).withValues(alpha: 0.08),
      offset: const Offset(0, 4),
      blurRadius: 12,
      spreadRadius: -2,
    ),
    BoxShadow(
      color: const Color(0xFF0F172A).withValues(alpha: 0.04),
      offset: const Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -2,
    ),
  ];
} 