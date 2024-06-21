import 'package:furniture_shopping_app_ui/models/product/product_model.dart';
import 'package:furniture_shopping_app_ui/res/assets/app_assets.dart';

class DummyProductList {
  static List<ProductModel> exploreList = <ProductModel>[
    ProductModel(
        productImage: AppAssets.product8,
        productName: 'Rak multifungsi',
        price: '100000'),
    ProductModel(
        productImage: AppAssets.product2,
        productName: 'Clasic brown chair',
        price: '120000'),
    ProductModel(
        productImage: AppAssets.product9,
        productName: 'Lemari serbaguna',
        price: '220000'),
    ProductModel(
        productImage: AppAssets.product4,
        productName: 'Pink Elegant chair',
        price: '450000'),
    ProductModel(
        productImage: AppAssets.product3,
        productName: 'Pink Elegant chair',
        price: '450000'),
  ];

  static List<ProductModel> bestSellingList = <ProductModel>[
    ProductModel(
        productImage: AppAssets.product4,
        productName: 'elegant chair',
        price: '350000'),
    ProductModel(
        productImage: AppAssets.product5,
        productName: 'Minimal chair',
        price: '250000'),
    ProductModel(
        productImage: AppAssets.product6,
        productName: 'black chair',
        price: '220000'),
    ProductModel(
        productImage: AppAssets.product7,
        productName: 'Mini chair',
        price: '450000'),
  ];

  static List<ProductModel> cartList = <ProductModel>[];
  static List<ProductModel> wishlist = <ProductModel>[];

  static List<ProductModel> get allProducts {
    return [
      ...exploreList,
      ...bestSellingList,
    ];
  }
}
