  import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prova_pratica_provider/main.dart';
import 'package:prova_pratica_provider/models/product.dart';
import 'package:prova_pratica_provider/providers/wishlist_provider.dart';

void main() {
  const sampleProduct1 = Product(
    id: 1,
    title: 'Notebook Teste',
    description: 'Descrição 1',
    category: 'Notebooks',
    price: 5000.0,
    rating: 4.9,
    imageUrl: 'https://example.com/1.png',
  );

  const sampleProduct2 = Product(
    id: 2,
    title: 'Mouse Teste',
    description: 'Descrição 2',
    category: 'Periféricos',
    price: 300.0,
    rating: 4.8,
    imageUrl: 'https://example.com/2.png',
  );

  group('Questão 1 (3,5 pts) - Testes Unitários do WishlistProvider', () {
    late WishlistProvider provider;

    setUp(() {
      provider = WishlistProvider();
    });

    test('Q1.1 e Q1.2: Deve iniciar vazio e atualizar count, totalEstimatedValue e isFavorite', () {
      expect(provider.items, isEmpty);
      expect(provider.count, equals(0));
      expect(provider.totalEstimatedValue, equals(0.0));
      expect(provider.isFavorite(1), isFalse);

      provider.toggleFavorite(sampleProduct1);
      provider.toggleFavorite(sampleProduct2);

      expect(provider.count, equals(2), reason: 'Q1.2a: count deve retornar 2 após favoritar 2 produtos');
      expect(
        provider.totalEstimatedValue,
        equals(5300.0),
        reason: 'Q1.2b: totalEstimatedValue deve somar os preços dos produtos favoritados (5000 + 300)',
      );
      expect(provider.isFavorite(1), isTrue, reason: 'Q1.2c: isFavorite(1) deve ser true');
    });

    test('Q1.3: toggleFavorite deve adicionar se não existir, remover se já existir e chamar notifyListeners()', () {
      int notifications = 0;
      provider.addListener(() => notifications++);

      // Adiciona
      provider.toggleFavorite(sampleProduct1);
      expect(provider.isFavorite(1), isTrue);
      expect(notifications, equals(1));

      // Remove ao chamar novamente
      provider.toggleFavorite(sampleProduct1);
      expect(provider.isFavorite(1), isFalse);
      expect(provider.count, equals(0));
      expect(notifications, equals(2));
    });

    test('Q1.4: removeProduct e clearWishlist devem funcionar e notificar ouvintes', () {
      provider.toggleFavorite(sampleProduct1);
      provider.toggleFavorite(sampleProduct2);
      expect(provider.count, equals(2));

      provider.removeProduct(1);
      expect(provider.isFavorite(1), isFalse);
      expect(provider.count, equals(1));

      provider.clearWishlist();
      expect(provider.items, isEmpty);
      expect(provider.count, equals(0));
      expect(provider.totalEstimatedValue, equals(0.0));
    });
  });

  group('Questões 2 a 5 (6,5 pts) - Integração do Provider na UI', () {
    testWidgets('Fluxo completo: Favoritar no card, atualizar Badge na AppBar e visualizar na WishlistScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(const FiapWishlistApp());

      // Verifica se a tela inicial carregou
      expect(find.text('FIAP Tech Wishlist'), findsOneWidget);

      // Clica no botão de favoritar do primeiro produto (id: 101)
      final favBtn101 = find.byKey(const ValueKey('fav_btn_101'));
      expect(favBtn101, findsOneWidget);
      await tester.tap(favBtn101);
      await tester.pump();

      // Questão 3: O badge na AppBar deve exibir '1'
      expect(
        find.text('1'),
        findsOneWidget,
        reason: 'Q2/Q3/Q4: Após favoritar um produto, o badge na AppBar deve exibir "1"',
      );

      // Abre a tela de Favoritos
      await tester.tap(find.byTooltip('Ver Meus Favoritos'));
      await tester.pumpAndSettle();

      // Questão 5.1: Verifica se o produto aparece na lista de favoritos e se mostra "1 produtos"
      expect(find.text('Meus Favoritos'), findsOneWidget);
      expect(find.text('1 produtos'), findsOneWidget);

      // Questão 5.2: Remove o item usando o botão de lixeira
      final removeBtn = find.byKey(const ValueKey('remove_fav_101'));
      expect(removeBtn, findsOneWidget);
      await tester.tap(removeBtn);
      await tester.pumpAndSettle();

      expect(find.text('Sua lista de desejos está vazia'), findsOneWidget);
    });
  });
}
