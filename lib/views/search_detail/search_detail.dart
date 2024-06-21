import 'package:flutter/material.dart';
import 'package:furniture_shopping_app_ui/models/product/product_model.dart';
import 'package:furniture_shopping_app_ui/res/assets/app_assets.dart';
import 'package:furniture_shopping_app_ui/res/colors/app_colors.dart';
import 'package:furniture_shopping_app_ui/res/components/dummy_product_lists.dart';
import 'package:furniture_shopping_app_ui/views/product%20_detail/product_detail.dart';

class DetailSearchView extends StatefulWidget {
  const DetailSearchView({Key? key}) : super(key: key);

  @override
  _DetailSearchViewState createState() => _DetailSearchViewState();
}

class _DetailSearchViewState extends State<DetailSearchView> {
  final TextEditingController _searchController = TextEditingController();
  List<ProductModel> _searchResults = [];

  void _searchProducts(String query) {
    final results = DummyProductList.exploreList.where((product) {
      return product.productName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _searchResults = results;
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _searchProducts(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        title: Row(
          children: [
            Expanded(
              child: Container(
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
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    prefixIcon: Image.asset(AppAssets.searchIcon),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: _searchResults.isNotEmpty
                  ? ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final product = _searchResults[index];
                        return ListTile(
                          leading: Image.asset(
                            product.productImage,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(product.productName),
                          subtitle: Text('\Rp.${product.price}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(
                                  productModel: product,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.buttonColor,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
