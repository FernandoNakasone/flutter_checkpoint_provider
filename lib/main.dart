import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:provider/provider.dart';
// ignore: unused_import
import 'providers/wishlist_provider.dart';
import 'screens/catalog_screen.dart';

void main() {
  runApp(const FiapWishlistApp());
}

/// ============================================================================
/// QUESTÃO 2 (1,5 PONTOS) — Registro Global do Provider na Árvore de Widgets
/// ============================================================================
/// Objetivo: Disponibilizar o `WishlistProvider` no topo da árvore de widgets
/// usando `ChangeNotifierProvider` (ou `MultiProvider`) para que tanto a
/// `CatalogScreen` quanto a `WishlistScreen` possam acessar o estado.
/// ============================================================================
class FiapWishlistApp extends StatelessWidget {
  const FiapWishlistApp({super.key});

  @override
  Widget build(BuildContext context) {
    // -------------------------------------------------------------------------
    // TODO (Questão 2 - 1,5 pts):
    // Envolva o `MaterialApp` abaixo com um `ChangeNotifierProvider` (ou
    // `MultiProvider`) criando a instância de `WishlistProvider()`.
    // -------------------------------------------------------------------------
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        // Provedor responsável pelo carrinho de compras e cálculo do total
      ],
      child: MaterialApp(
      title: 'FIAP Tech Wishlist - Prova Provider',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE91E63), // Pink / Magenta FIAP
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 2,
        ),
      ),
      home: const CatalogScreen(),
    ),
    );
  }
}
