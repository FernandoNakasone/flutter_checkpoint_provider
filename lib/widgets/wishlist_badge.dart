import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:provider/provider.dart';
// ignore: unused_import
import '../providers/wishlist_provider.dart';
import '../screens/wishlist_screen.dart';

/// ============================================================================
/// QUESTÃO 3 (1,5 PONTOS) — Contador Reativo na AppBar com Consumer
/// ============================================================================
/// Objetivo: Exibir o total de produtos favoritados no ícone da AppBar
/// reconstruindo apenas este widget quando a lista de favoritos mudar.
/// ============================================================================
class WishlistBadge extends StatelessWidget {
  const WishlistBadge({super.key});

  @override
  Widget build(BuildContext context) {
    // -------------------------------------------------------------------------
    // TODO (Questão 3 - 1,5 pts):
    // Envolva o retorno abaixo com um `Consumer<WishlistProvider>` (ou utilize
    // o provider) para que `favoriteCount` receba dinamicamente `wishlist.count`.
    // -------------------------------------------------------------------------
  // <-- Substitua pelo contador vindo do Provider!

    return Consumer<WishlistProvider>(
      builder: (context, wishlist, child) {
        final int favoriteCount = wishlist.count; 
      return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          tooltip: 'Ver Meus Favoritos',
          icon: const Icon(Icons.favorite_border_rounded),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const WishlistScreen()),
            );
          },
        ),
        if (favoriteCount > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                favoriteCount.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
      );
      },
    );
  }
}
