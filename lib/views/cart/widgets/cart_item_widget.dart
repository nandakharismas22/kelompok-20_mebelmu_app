import 'package:flutter/material.dart';
import 'package:furniture_shopping_app_ui/models/product/product_model.dart';
import 'package:furniture_shopping_app_ui/res/components/dummy_product_lists.dart';
import 'package:furniture_shopping_app_ui/res/colors/app_colors.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel productModel;
  final int index;
  final VoidCallback onUpdate;

  CartItemWidget({
    required this.productModel,
    required this.index,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Container(
        height: 70, // Set height to 120 pixels
        width: 100, // Set width based on screen width
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
          ],
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(
                4.0), // Rounded corners for the product image
            child: Image.asset(productModel.productImage),
          ),
          title: Text(productModel.productName),
          subtitle: Text('Harga: ${productModel.price}'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              DummyProductList.cartList.removeAt(index);
              onUpdate();
            },
          ),
        ),
      ),
    );
  }
}
