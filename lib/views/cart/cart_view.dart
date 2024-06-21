import 'package:flutter/material.dart';
import 'package:furniture_shopping_app_ui/res/components/app_bar_widget.dart';
import 'package:furniture_shopping_app_ui/res/components/custom_button.dart';
import 'package:furniture_shopping_app_ui/res/components/dummy_product_lists.dart';
import 'package:furniture_shopping_app_ui/views/cart/widgets/bottom_text_widget.dart';
import 'package:furniture_shopping_app_ui/views/cart/widgets/cart_item_widget.dart';
import '../../res/colors/app_colors.dart';
import '../../view_models/cart/cart_view_model.dart';
import '../home/home_view.dart';
import '../shipping/choose_shipping_page.dart';
import 'package:furniture_shopping_app_ui/res/assets/app_assets.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final cartVM = CartViewModel();
  late double totalPrice;
  double ongkir = 0.0;
  bool isShippingSelected = false;

  @override
  void initState() {
    super.initState();
    totalPrice = cartVM.totalSelectedPrice;
    print('Initial Total Price: $totalPrice');
  }

  void updateTotalPrice() {
    setState(() {
      totalPrice = cartVM.totalSelectedPrice + ongkir;
      print('Updated Total Price: $totalPrice');
    });
  }

  void showCheckoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor:
              AppColors.backGroundColor, // Set background color to white
          contentPadding: EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                AppAssets.popup,
                height: 100,
              ),
              SizedBox(height: 10),
              Text(
                'Congratulation!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.buttonColor, 
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Barang Anda telah berhasil dicheckout silahkan lanjut berbelanja lagi.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.buttonColor, 
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor, 
                ),
                child: Text(
                  'Selesai',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.whiteColor, 
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomeView()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        elevation: 0,
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        title: const AppBarWidget(title: 'Cart'),
        iconTheme: IconThemeData(color: AppColors.buttonColor),
      ),
      body: Column(
        children: [
          const SizedBox(height: 0),
          Expanded(
            child: ListView.separated(
              itemCount: DummyProductList.cartList.length,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              separatorBuilder: (context, child) => const SizedBox(height: 0),
              itemBuilder: (context, index) {
                return CartItemWidget(
                  productModel: DummyProductList.cartList[index],
                  index: index,
                  onUpdate: updateTotalPrice,
                );
              },
            ),
          ),
          const SizedBox(height: 25),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 50),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor,
                  spreadRadius: 6,
                  blurRadius: 5,
                  offset: const Offset(-5, -4.0),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 0),
                BottomTextWidget(
                  price: (totalPrice - ongkir).toStringAsFixed(0),
                  leadingText: 'Sub Total',
                  isSubT: true,
                ),
                const SizedBox(height: 0),
                BottomTextWidget(
                  price: isShippingSelected ? ongkir.toStringAsFixed(0) : '0',
                  leadingText: 'Ongkir',
                  isSubT: true,
                ),
                //const Divider(color: Colors.grey),
                BottomTextWidget(
                  price: totalPrice.toStringAsFixed(0),
                  leadingText: 'Total',
                  isSubT: false,
                ),
                const SizedBox(height: 22),
                CustomButton(
                  width: size.width * 0.8,
                  title: isShippingSelected ? 'Bayar' : 'Pilih Pengiriman',
                  onTap: () {
                    if (!isShippingSelected) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChooseShippingPage(),
                        ),
                      ).then((selectedOngkir) {
                        if (selectedOngkir != null) {
                          setState(() {
                            ongkir = selectedOngkir;
                            isShippingSelected = true;
                            updateTotalPrice();
                          });
                        }
                      });
                    } else {
                      showCheckoutDialog();
                    }
                  },
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
