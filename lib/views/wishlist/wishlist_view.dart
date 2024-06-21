import 'package:flutter/material.dart';
import 'package:furniture_shopping_app_ui/models/product/product_model.dart';
import 'package:furniture_shopping_app_ui/res/colors/app_colors.dart';
import 'package:furniture_shopping_app_ui/res/components/dummy_product_lists.dart';
import 'package:furniture_shopping_app_ui/views/cart/cart_view.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({Key? key}) : super(key: key);

  @override
  _WishlistViewState createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  List<ProductModel> wishlist = DummyProductList.wishlist;

  void _removeFromWishlist(ProductModel product) {
    setState(() {
      wishlist.remove(product);
    });
  }

  void _addToCart(ProductModel product) {
    setState(() {
      DummyProductList.cartList.add(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.productName} added to cart'),
      ),
    );

    _removeFromWishlist(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: wishlist.isEmpty
          ? Center(
              child: Text(
                'Wishlist Anda Kosong',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 0),
                Expanded(
                  child: ListView.separated(
                    itemCount: wishlist.length,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      var product = wishlist[index];
                      return WishlistTile(
                        product: product,
                        onRemove: () => _removeFromWishlist(product),
                        onAddToCart: () => _addToCart(product),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class WishlistTile extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onRemove;
  final VoidCallback onAddToCart;

  const WishlistTile({
    Key? key,
    required this.product,
    required this.onRemove,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            spreadRadius: 2.0,
            blurRadius: 4.0,
            offset: const Offset(-2.0, -2.0),
          ),
          BoxShadow(
            color: AppColors.shadowColor,
            spreadRadius: 2.0,
            blurRadius: 4.0,
            offset: const Offset(2.0, 2.0),
          ),
        ],
      ),
      child: ListTile(
        leading: Image.asset(
          product.productImage,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(product.productName),
        subtitle: Text('\Rp.${product.price}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.add_shopping_cart,
                color: Color.fromARGB(255, 18, 39, 99),
              ),
              onPressed: () {
                onAddToCart();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartView()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
