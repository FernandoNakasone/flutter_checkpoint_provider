import 'package:flutter/material.dart';
import '../models/product.dart';

/// Serviço local com dados mockados de produtos de tecnologia.
/// Garante funcionamento instantâneo em laboratório sem depender de rede externa.
/// (ARQUIVO PRONTO — Não é necessário alterar na prova).
class MockProductService {
  static const List<Product> _products = [
    Product(
      id: 101,
      title: 'MacBook Pro 14" M3',
      description: 'Chip Apple M3 de 8 núcleos, 16GB RAM, SSD 512GB, Tela Liquid Retina XDR.',
      category: 'Notebooks',
      price: 12499.00,
      rating: 4.9,
      imageUrl: 'https://cdn.dummyjson.com/product-images/laptops/apple-macbook-pro-14-inch-space-grey/thumbnail.webp',
      fallbackIcon: Icons.laptop_mac_rounded,
    ),
    Product(
      id: 102,
      title: 'Headphone Wireless ANC Pro',
      description: 'Cancelamento ativo de ruído de alta precisão, bateria de 30h e áudio Hi-Res.',
      category: 'Áudio',
      price: 1899.90,
      rating: 4.8,
      imageUrl: 'https://cdn.dummyjson.com/product-images/mobile-accessories/apple-airpods-max-silver/thumbnail.webp',
      fallbackIcon: Icons.headphones_rounded,
    ),
    Product(
      id: 103,
      title: 'Smartphone Galaxy Ultra 5G',
      description: 'Tela AMOLED 120Hz de 6.8", câmera de 200MP, 512GB de armazenamento.',
      category: 'Smartphones',
      price: 6299.00,
      rating: 4.7,
      imageUrl: 'https://cdn.dummyjson.com/product-images/smartphones/samsung-galaxy-s10/thumbnail.webp',
      fallbackIcon: Icons.smartphone_rounded,
    ),
    Product(
      id: 104,
      title: 'Teclado Mecânico RGB Sem Fio',
      description: 'Switches táteis silenciosos, conexão Bluetooth e USB-C, estrutura em alumínio.',
      category: 'Periféricos',
      price: 749.90,
      rating: 4.8,
      imageUrl: 'https://cdn.dummyjson.com/product-images/laptops/asus-zenbook-pro-dual-screen-laptop/thumbnail.webp',
      fallbackIcon: Icons.keyboard_alt_outlined,
    ),
    Product(
      id: 105,
      title: 'Smartwatch Series 9 GPS',
      description: 'Monitoramento avançado de saúde, ECG, resistência à água 50m e tela Always-On.',
      category: 'Wearables',
      price: 3199.00,
      rating: 4.6,
      imageUrl: 'https://cdn.dummyjson.com/product-images/mobile-accessories/apple-watch-series-4-gold/thumbnail.webp',
      fallbackIcon: Icons.watch_rounded,
    ),
    Product(
      id: 106,
      title: 'Mouse Ergonômico Master 3S',
      description: 'Sensor óptico de 8000 DPI, rolagem eletromagnética MagSpeed e cliques silenciosos.',
      category: 'Periféricos',
      price: 599.90,
      rating: 4.9,
      imageUrl: 'https://cdn.dummyjson.com/product-images/mobile-accessories/beats-flex-wireless-earphones/thumbnail.webp',
      fallbackIcon: Icons.mouse_rounded,
    ),
    Product(
      id: 107,
      title: 'Tablet Pro 11" Wi-Fi 256GB',
      description: 'Desempenho profissional para estudos, design digital e multitarefa com suporte a caneta.',
      category: 'Tablets',
      price: 5490.00,
      rating: 4.7,
      imageUrl: 'https://cdn.dummyjson.com/product-images/tablets/ipad-mini-2021-starlight/thumbnail.webp',
      fallbackIcon: Icons.tablet_mac_rounded,
    ),
    Product(
      id: 108,
      title: 'Caixa de Som Smart Studio',
      description: 'Som espacial 360 graus com graves profundos e assistente de voz integrado.',
      category: 'Áudio',
      price: 899.00,
      rating: 4.5,
      imageUrl: 'https://cdn.dummyjson.com/product-images/mobile-accessories/apple-homepod-mini-cosmic-grey/thumbnail.webp',
      fallbackIcon: Icons.speaker_rounded,
    ),
  ];

  /// Retorna todos os produtos do catálogo.
  static List<Product> getProducts() => List.unmodifiable(_products);

  /// Retorna a lista de categorias únicas presentes no catálogo.
  static List<String> getCategories() {
    return _products.map((p) => p.category).toSet().toList();
  }
}
