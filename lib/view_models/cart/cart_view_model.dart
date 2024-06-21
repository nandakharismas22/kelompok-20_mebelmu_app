import 'package:furniture_shopping_app_ui/res/components/dummy_product_lists.dart';

class CartViewModel {
  Map<int, int> selectedItems = {};

  // Getter untuk mengembalikan daftar indeks item yang dipilih
  List<int> get cartList => selectedItems.keys.toList();

  // Metode untuk menghitung total harga item yang dipilih
  double get totalSelectedPrice {
    double total = 0.0;
    for (var product in DummyProductList.cartList) {
      total += double.tryParse(
              product.price.replaceAll('.', '').replaceAll(',', '.')) ??
          0.0;
    }
    print('Total Selected Price: $total'); // Debugging output
    return total;
  }

// Metode untuk menambah atau mengurangi jumlah item yang dipilih
  void toggleItemSelection(int index) {
    if (selectedItems.containsKey(index)) {
      selectedItems.remove(index);
    } else {
      selectedItems[index] = 1;
    }
  }
}
