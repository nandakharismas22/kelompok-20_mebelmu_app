import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_shopping_app_ui/models/product/product_model.dart';
import 'package:furniture_shopping_app_ui/res/components/dummy_product_lists.dart';

class Utils {
  static bool addToCart(ProductModel productModel) {
    if (!DummyProductList.cartList.contains(productModel)) {
      DummyProductList.cartList.add(productModel);
      return true;
    }
    return false;
  }

  static void toastMessage({String message = 'Added to Cart!'}) {
    Fluttertoast.showToast(msg: message);
  }

  static bool addToWish(ProductModel productModel) {
    if (!DummyProductList.wishlist.contains(productModel)) {
      DummyProductList.wishlist.add(productModel);
      return true;
    }
    return false;
  }

  static void wishMessage({String message = 'Added to Wishlist!'}) {
    Fluttertoast.showToast(msg: message);
  }
}
