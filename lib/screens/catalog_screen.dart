import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/mock_product_service.dart';
import '../widgets/product_card.dart';
import '../widgets/wishlist_badge.dart';

/// Tela de Catálogo de Produtos.
/// (ARQUIVO PRONTO — Não é necessário alterar na prova).
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final List<Product> _allProducts = MockProductService.getProducts();
  final List<String> _categories = MockProductService.getCategories();
  String? _selectedCategory;

  List<Product> get _filteredProducts {
    if (_selectedCategory == null) return _allProducts;
    return _allProducts
        .where((p) => p.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.bolt_rounded),
            SizedBox(width: 8),
            Text(
              'FIAP Tech Wishlist',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: const [
          WishlistBadge(),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Filtro de categorias
          SizedBox(
            height: 50,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length + 1,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final isAll = index == 0;
                final category = isAll ? null : _categories[index - 1];
                final isSelected = _selectedCategory == category;

                return FilterChip(
                  label: Text(isAll ? 'Todos' : category!),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                );
              },
            ),
          ),

          // Grade de produtos
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 900
                    ? 4
                    : (constraints.maxWidth > 600 ? 3 : 2);

                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: _filteredProducts.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: _filteredProducts[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
