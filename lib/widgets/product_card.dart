import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:provider/provider.dart';
import '../models/product.dart';
// ignore: unused_import
import '../providers/wishlist_provider.dart';
import '../utils/currency_formatter.dart';

/// ============================================================================
/// QUESTÃO 4 (1,5 PONTOS) — Interação de Favoritar no Card do Produto
/// ============================================================================
/// Objetivo:
/// 4.1 Verificar se o produto está favoritado para pintar o ícone de coração.
/// 4.2 Disparar o método `toggleFavorite(product)` ao clicar no botão.
/// ============================================================================
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // -------------------------------------------------------------------------
    // TODO (Questão 4.1 - 0,75 pt):
    // Escute o `WishlistProvider` (via `context.watch<WishlistProvider>()`)
    // e verifique se este produto está favoritado usando `isFavorite(product.id)`.
    // -------------------------------------------------------------------------
    bool isFav = context.watch<WishlistProvider>().isFavorite(product.id); // <-- Substitua pela verificação no WishlistProvider!

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagem do produto + Botão de Favorito no topo direito
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.grey.shade100,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Center(
                      child: Icon(
                        product.fallbackIcon,
                        size: 56,
                        color: theme.colorScheme.primary.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ),
                // Avaliação (Estrela)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text(
                          product.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Botão de Coração (Favoritar / Desfavoritar)
                Positioned(
                  top: 4,
                  right: 4,
                  child: Material(
                    color: Colors.white.withValues(alpha: 0.9),
                    shape: const CircleBorder(),
                    child: IconButton(
                      key: ValueKey('fav_btn_${product.id}'),
                      tooltip: isFav ? 'Remover dos favoritos' : 'Adicionar aos favoritos',
                      icon: Icon(
                        isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        color: isFav ? Colors.pinkAccent : Colors.grey.shade700,
                      ),
                      onPressed: () {
                        // -------------------------------------------------------
                        // TODO (Questão 4.2 - 0,75 pt):
                        // Chame o método `toggleFavorite(product)` do `WishlistProvider`
                        // utilizando `context.read<WishlistProvider>()`.
                        // -------------------------------------------------------

                        context.read<WishlistProvider>().toggleFavorite(product);

                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Detalhes do Produto
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.category.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  CurrencyFormatter.format(product.price),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
