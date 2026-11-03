import 'package:flutter/material.dart';

/// Modelo que representa um produto no catálogo da FIAP Tech Store.
/// (ARQUIVO PRONTO — Não é necessário alterar na prova).
class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double rating;
  final String imageUrl;
  final IconData fallbackIcon;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.imageUrl,
    this.fallbackIcon = Icons.devices_other_rounded,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
