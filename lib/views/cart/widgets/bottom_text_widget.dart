import 'package:flutter/material.dart';
import 'package:furniture_shopping_app_ui/res/components/dummy_product_lists.dart';
import '../../../res/colors/app_colors.dart';

class BottomTextWidget extends StatelessWidget {
  const BottomTextWidget({
    Key? key,
    required this.price,
    required this.leadingText,
    required this.isSubT,
  }) : super(key: key);

  final String leadingText;
  final String price;
  final bool isSubT;

  @override
  Widget build(BuildContext context) {
    var newPrice = DummyProductList.cartList.isEmpty ? '0' : price;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leadingText,
              style: isSubT
                  ? Theme.of(context).textTheme.titleMedium
                  : Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.buttonColor,
                      ),
            ),
            Text(
              '\Rp$newPrice',
              style: isSubT
                  ? Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.lightRed,
                        fontSize: 18,
                      )
                  : Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightRed,
                      ),
            ),
          ],
        ),
        if (leadingText == 'Ongkir')
          Divider(
            color: AppColors.shadowColor,
            thickness: 1,
          ),
      ],
    );
  }
}
