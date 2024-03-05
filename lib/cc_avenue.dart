import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cc_avenue/data/payData.dart';
import '../cc_avenue/utility/urlList.dart';

class CcAvenueService {
  Future<PaymentData?> fetchMerchantEncryptedData(int amount) async {
    try {
      final response = await Dio().post(
        UrlList.merchant_server_enc_url,
        data: {'amount': amount},
      );

      print("response is ${response.data}");

      // final json = jsonDecode(response.data);
      return PaymentData.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void handleCcAvenuePaymentStatus(BuildContext context, Map<String, dynamic> jsonData) async {
    if (jsonData['status_message'] == 'SUCCESS') {

      try {
        // Payment success
        // save payment details
      } catch (e) {
        print("Error during spin purchase: $e");
      }
    } else {
      print("Error during spin purchase");
      if (jsonData['status_message']) {
        if (jsonData['status_message'] != "") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(jsonData['status_message'])));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error during spin purchase")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error during spin purchase")));
      }
    }
    Navigator.of(context).pop();
  }
}
