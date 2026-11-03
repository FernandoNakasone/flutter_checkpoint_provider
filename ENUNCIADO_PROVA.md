# 📝 Prova Prática — Gerenciamento de Estado com Provider (Flutter)

- **Disciplina:** Desenvolvimento Mobile / Flutter (FIAP)
- **Valor Total:** 10,0 pontos
- **Duração Máxima:** 60 minutos
- **Tema do Projeto:** *FIAP Tech Wishlist* (Catálogo de Produtos com Lista de Desejos)

---

## 🎯 Contexto e Objetivo

Você recebeu o projeto base do aplicativo **FIAP Tech Wishlist**, uma vitrine de produtos de tecnologia. A interface visual (telas, cards, formatação de moeda e lista de produtos mockados) **já está pronta**.

Sua missão nesta avaliação é implementar o **gerenciamento de estado reativo da Lista de Desejos (Favoritos / Wishlist)** utilizando o pacote **`provider`**, permitindo que o usuário:
1. Favorite ou desfavorite produtos no catálogo clicando no ícone de coração.
2. Veja o contador de favoritos atualizado em tempo real no topo da tela (`AppBar`).
3. Acesse a tela **"Meus Favoritos"** para visualizar os itens salvos, o **valor total estimado** da lista, remover itens individualmente ou limpar toda a lista.

---

## 🔍 Onde trabalhar?

Procure pelos comentários marcados com `// TODO (Questão X)` nos seguintes 5 arquivos:
1. `lib/providers/wishlist_provider.dart`
2. `lib/main.dart`
3. `lib/widgets/wishlist_badge.dart`
4. `lib/widgets/product_card.dart`
5. `lib/screens/wishlist_screen.dart`

> **Dica:** Você **não** precisa alterar os arquivos das pastas `models/`, `services/` ou `utils/`.

---

## 📋 Questões e Critérios de Avaliação (10,0 Pontos)

### Questão 1 — Implementação do `WishlistProvider` (3,5 pontos)
**Arquivo:** `lib/providers/wishlist_provider.dart`

Implemente a lógica da classe `WishlistProvider` para gerenciar os produtos favoritados:
- **1.1 (0,5 pt):** Garantir que a classe utilize `ChangeNotifier` e exponha a lista imutável de produtos favoritados no getter `items`.
- **1.2 (1,0 pt):** Implementar os métodos e getters de consulta:
  - `count`: deve retornar a quantidade total de produtos na lista de desejos.
  - `totalEstimatedValue`: deve somar e retornar o valor (`price`) de todos os produtos favoritados.
  - `isFavorite(int productId)`: deve retornar `true` se o produto com aquele `id` estiver na lista, ou `false` caso contrário.
- **1.3 (1,0 pt):** Implementar o método `toggleFavorite(Product product)`:
  - Se o produto **já estiver** nos favoritos, remova-o.
  - Se o produto **não estiver** nos favoritos, adicione-o.
  - Notifique os widgets ouvintes utilizando `notifyListeners()`.
- **1.4 (1,0 pt):** Implementar os métodos `removeProduct(int productId)` e `clearWishlist()`, removendo o item (ou limpando toda a lista) e chamando `notifyListeners()`.

---

### Questão 2 — Registro do Provider na Árvore de Widgets (1,5 pontos)
**Arquivo:** `lib/main.dart`

- No widget raiz `FiapWishlistApp`, envolva o `MaterialApp` com um `ChangeNotifierProvider` (ou `MultiProvider`) disponibilizando a instância de `WishlistProvider` para toda a aplicação.

---

### Questão 3 — Contador Reativo na AppBar com `Consumer` (1,5 pontos)
**Arquivo:** `lib/widgets/wishlist_badge.dart`

- Utilize o widget `Consumer<WishlistProvider>` para escutar alterações no estado de favoritos apenas no componente do ícone da `AppBar`.
- Atualize a variável `favoriteCount` com o total de itens do provider (`wishlist.count`) para que o badge numérico apareça e atualize automaticamente sempre que um produto for favoritado ou removido.

---

### Questão 4 — Interação no Card do Produto (1,5 pontos)
**Arquivo:** `lib/widgets/product_card.dart`

- **4.1 (0,75 pt):** Obtenha o status `isFavorite` do produto atual através do `WishlistProvider` (usando `context.watch` ou `Consumer`) para que o ícone exiba um coração preenchido vermelho (`Icons.favorite`) quando favoritado, ou vazado (`Icons.favorite_border`) quando não favoritado.
- **4.2 (0,75 pt):** No evento `onPressed` do botão de coração, utilize `context.read<WishlistProvider>()` para chamar `toggleFavorite(product)`.

---

### Questão 5 — Tela de Favoritos e Resumo Financeiro (2,0 pontos)
**Arquivo:** `lib/screens/wishlist_screen.dart`

- **5.1 (1,0 pt):** No método `build` da `WishlistScreen`, utilize `context.watch<WishlistProvider>()` para obter a lista de produtos favoritados (`items`), a quantidade total (`count`) e o valor total estimado (`totalEstimatedValue`), exibindo-os na listagem e no card de resumo inferior.
- **5.2 (1,0 pt):** Conecte as ações de exclusão utilizando `context.read<WishlistProvider>()`:
  - No botão de lixeira de cada item da lista, chame `removeProduct(product.id)`.
  - Na confirmação do botão **"Limpar Lista"** da `AppBar`, chame `clearWishlist()`.

---

## ✅ Checklist de Entrega

Antes de entregar, verifique se:
- [ ] Ao clicar no coração de um produto no catálogo, ele muda de cor para vermelho.
- [ ] O contador no topo direito (`AppBar`) aumenta e diminui conforme você favorita ou desfavorita itens.
- [ ] Na tela **"Meus Favoritos"**, todos os itens selecionados aparecem com a soma correta do **Valor Total Estimado**.
- [ ] O botão de excluir um item individual e o botão de limpar toda a lista funcionam e atualizam a tela imediatamente.
- [ ] O comando `flutter test` passa em todos os testes!
