import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:provider/provider.dart';
import '../models/product.dart';
// ignore: unused_import
import '../providers/wishlist_provider.dart';
import '../utils/currency_formatter.dart';

/// ============================================================================
/// QUESTÃO 5 (2,0 PONTOS) — Tela de Favoritos e Resumo Financeiro
/// ============================================================================
/// Objetivo:
/// 5.1 Observar o `WishlistProvider` com `context.watch<WishlistProvider>()`
///     para listar os itens favoritados e mostrar o valor total estimado.
/// 5.2 Conectar os botões de remover item (`removeProduct`) e limpar toda a
///     lista (`clearWishlist`) usando `context.read<WishlistProvider>()`.
/// ============================================================================
class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // -------------------------------------------------------------------------
    // TODO (Questão 5.1 - 1,0 pt):
    // Utilize `context.watch<WishlistProvider>()` para preencher as 3 variáveis
    // abaixo com os dados reais vindos do Provider (`items`, `count` e
    // `totalEstimatedValue`).
    // -------------------------------------------------------------------------
    final List<Product> favoriteItems = context.watch<WishlistProvider>().items; // <-- Substitua por wishlist.items
    final int itemCount = context.watch<WishlistProvider>().count; // <-- Substitua por wishlist.count
    final double totalValue = context.watch<WishlistProvider>().totalEstimatedValue;// <-- Substitua por wishlist.totalEstimatedValue

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Favoritos'),
        actions: [
          if (favoriteItems.isNotEmpty)
            IconButton(
              key: const ValueKey('clear_wishlist_btn'),
              icon: const Icon(Icons.delete_sweep_outlined),
              tooltip: 'Limpar Lista de Desejos',
              onPressed: () {
                // -------------------------------------------------------------
                // TODO (Questão 5.2a - 0,5 pt):
                // Chame `clearWishlist()` do `WishlistProvider` usando `context.read`.
                // -------------------------------------------------------------

                context.read<WishlistProvider>().clearWishlist();

              },
            ),
        ],
      ),
      body: favoriteItems.isEmpty
          ? _buildEmptyState(context)
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 140),
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                final product = favoriteItems[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 56,
                        height: 56,
                        color: Colors.grey.shade100,
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Icon(
                            product.fallbackIcon,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      product.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      CurrencyFormatter.format(product.price),
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      key: ValueKey('remove_fav_${product.id}'),
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.redAccent,
                      ),
                      tooltip: 'Remover dos favoritos',
                      onPressed: () {
                        // -----------------------------------------------------
                        // TODO (Questão 5.2b - 0,5 pt):
                        // Chame `removeProduct(product.id)` do `WishlistProvider`
                        // usando `context.read<WishlistProvider>()`.
                        // -----------------------------------------------------
                        context.read<WishlistProvider>().removeProduct(product.id);
                      },
                    ),
                  ),
                );
              },
            ),
      bottomSheet: favoriteItems.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Itens na Lista de Desejos:',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        Text(
                          '$itemCount produtos',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Valor Total Estimado:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          CurrencyFormatter.format(totalValue),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border_rounded,
              size: 72,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            const Text(
              'Sua lista de desejos está vazia',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Toque no coração nos cards do catálogo para salvar seus produtos favoritos aqui!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
