import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'package:furniture_shopping_app_ui/res/colors/app_colors.dart';
import 'package:furniture_shopping_app_ui/models/api/model_kota.dart';

class ChooseShippingPage extends StatefulWidget {
  @override
  State<ChooseShippingPage> createState() => _ChooseShippingPageState();
}

class _ChooseShippingPageState extends State<ChooseShippingPage> {
  var strKey = "e7d348fb05ff05b390711fd7bf6600ed";
  String? strKotaAsal;
  String? strKotaTujuan;
  String? strBerat;
  String? strEkspedisi;
  List listData = [];

  Future<List<ModelKota>> _getKotaList() async {
    final response = await http
        .get(Uri.parse("https://api.rajaongkir.com/starter/city?key=$strKey"));
    if (response.statusCode == 200) {
      List allKota = (jsonDecode(response.body)
          as Map<String, dynamic>)['rajaongkir']['results'];
      return ModelKota.fromJsonList(allKota);
    } else {
      throw Exception('Failed to load cities');
    }
  }

  void _cekOngkir() async {
    if (strKotaAsal == null ||
        strKotaTujuan == null ||
        strBerat == null ||
        strEkspedisi == null) {
      const snackBar = SnackBar(content: Text("Ups, form tidak boleh kosong!"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final response = await http.post(
        Uri.parse("https://api.rajaongkir.com/starter/cost"),
        headers: {
          "key": strKey,
          "content-type": "application/x-www-form-urlencoded",
        },
        body: {
          "origin": strKotaAsal,
          "destination": strKotaTujuan,
          "weight": strBerat,
          "courier": strEkspedisi,
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          listData = data['rajaongkir']['results'][0]['costs'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        elevation: 0,
        toolbarHeight: 90,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Pilih Pengiriman',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.buttonColor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Form Pemilihan Ongkir',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              DropdownSearch<ModelKota>(
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Kota Asal",
                    hintText: "Pilih Kota Asal",
                    border: OutlineInputBorder(),
                  ),
                ),
                popupProps: const PopupProps.menu(
                  showSearchBox: true,
                  fit: FlexFit.loose,
                ),
                onChanged: (value) {
                  setState(() {
                    strKotaAsal = value?.cityId;
                  });
                },
                itemAsString: (item) => "${item.type} ${item.cityName}",
                asyncItems: (text) => _getKotaList(),
              ),
              const SizedBox(height: 20),
              DropdownSearch<ModelKota>(
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Kota Tujuan",
                    hintText: "Pilih Kota Tujuan",
                    border: OutlineInputBorder(),
                  ),
                ),
                popupProps: const PopupProps.menu(
                  showSearchBox: true,
                  fit: FlexFit.loose,
                ),
                onChanged: (value) {
                  setState(() {
                    strKotaTujuan = value?.cityId;
                  });
                },
                itemAsString: (item) => "${item.type} ${item.cityName}",
                asyncItems: (text) => _getKotaList(),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Berat Paket (gram)',
                  hintText: 'Input Berat Paket',
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  setState(() {
                    strBerat = text;
                  });
                },
              ),
              const SizedBox(height: 20),
              DropdownSearch<String>(
                items: const ["JNE", "TIKI", "POS"],
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Kurir",
                    hintText: "Kurir",
                    border: OutlineInputBorder(),
                  ),
                ),
                popupProps: PopupPropsMultiSelection.menu(
                  showSelectedItems: true,
                  fit: FlexFit.loose,
                  disabledItemFn: (String s) => s.startsWith('I'),
                ),
                onChanged: (text) {
                  setState(() {
                    strEkspedisi = text?.toLowerCase();
                  });
                },
              ),
              const SizedBox(height: 30, width: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _cekOngkir,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Cek Ongkir',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (listData.isNotEmpty)
                ListView(
                  shrinkWrap: true,
                  children: listData.map((data) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      clipBehavior: Clip.antiAlias,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: AppColors.whiteColor,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        title: Text(
                          "${data['service']}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          "${data['description']}",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Rp. ${data['cost'][0]['value']}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "${data['cost'][0]['etd']} Days",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(context, data['cost'][0]['value']);
                        },
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
