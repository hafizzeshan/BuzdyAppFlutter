import 'package:buzdy/mainresponse/loginresponcedata.dart';
import 'package:buzdy/repository/auth_api/auth_http_api_repository.dart';
import 'package:buzdy/response/api_response.dart';
import 'package:buzdy/response/status.dart';
import 'package:buzdy/screens/dashboard.dart';
import 'package:buzdy/screens/dashboard/home/model/bankModel.dart';
import 'package:buzdy/screens/dashboard/home/model/merchnatModel.dart';
import 'package:buzdy/views/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel extends ChangeNotifier {
  // Bank Data
  List<Bank> bankList = [];
  int bankcurrentPage = 1; // Track the current page
  bool bankisLoadingMore = false; // Track if more data is being fetched
  bool bankhasMoreData = true; // If no more pages, stop loading
  //Merchant Data
  List<MerchantModelData> merchantList = [];

  int merchantcurrentPage = 1; // Track the current page
  bool merchantisLoadingMore = false; // Track if more data is being fetched
  bool merchanthasMoreData = true; // If no more pages, stop loading
  UserViewModel() {
    getAllBanks(pageNumber: bankcurrentPage);
    getAllMarchants(pageNumber: merchantcurrentPage);
  }
  // auth
  Future login({payload}) async {
    AuthHttpApiRepository repository = AuthHttpApiRepository();
    easyLoadingStart();
    ApiResponse res = await repository.loginApi(payload);
    Responses ress = res.data;

    if (ress.status == 1) {
      print("RESPOSNE----------- ${ress.data}");
      easyLoadingStop();
      UIHelper.showMySnak(
          title: "Buzdy", message: "Login successfully", isError: false);
      await savetoken(token: ress.data['token'].toString());
      // await savePhone(phone: payload['phoneNumber']);
      Get.offAll(DashBorad(index: 0));
      //  await getApiToken();
    } else {
      easyLoadingStop();
      UIHelper.showMySnak(
          title: "ERROR", message: ress.message.toString(), isError: true);
    }
  }

//register
  Future register({payload}) async {
    AuthHttpApiRepository repository = AuthHttpApiRepository();
    easyLoadingStart();
    ApiResponse res = await repository.registerApi(payload);
    Responses ress = res.data;

    if (ress.status == 1) {
      print("RESPOSNE----------- ${ress.data}");
      easyLoadingStop();
      UIHelper.showMySnak(
          title: "Buzdy", message: "Register successfully", isError: false);
      await savetoken(token: ress.data['token'].toString());
      // await savePhone(phone: payload['phoneNumber']);
      Get.offAll(DashBorad(index: 0));
      //  await getApiToken();
    } else {
      easyLoadingStop();
      UIHelper.showMySnak(
          title: "ERROR", message: ress.message.toString(), isError: true);
    }
  }

  // banks
  Future getAllBanks({required int pageNumber}) async {
    print("bank---------");
    if (bankisLoadingMore) return; // Prevent multiple API calls

    bankisLoadingMore = true;
    notifyListeners();

    AuthHttpApiRepository repository = AuthHttpApiRepository();
    ApiResponse res = await repository.getAllBanks(PageNumber: pageNumber);

    if (res.status == Status.completed) {
      Responses ress = res.data;
      if (ress.status == 1) {
        BankModel model = BankModel.fromJson({
          "status": ress.status,
          "message": ress.message,
          "banks": ress.data,
          "pagination": ress.pagination
        });

        if (model.banks.isNotEmpty) {
          bankList.addAll(model.banks); // Append new banks to the list
          bankcurrentPage++; // Move to next page
          print("Fetching more banks... Page: $pageNumber");
          print("Total banks loaded: ${bankList.length}");
        } else {
          bankhasMoreData = false; // No more data to load
        }
      }
    } else {
      UIHelper.showMySnak(
          title: "ERROR", message: res.message.toString(), isError: true);
    }

    bankisLoadingMore = false;
    notifyListeners();
  }

  Future getAllMarchants({required int pageNumber}) async {
    print("merchnat---------");

    if (merchantisLoadingMore) return; // Prevent multiple API calls

    merchantisLoadingMore = true;
    notifyListeners();

    AuthHttpApiRepository repository = AuthHttpApiRepository();
    ApiResponse res = await repository.getAllMerchants(PageNumber: pageNumber);

    if (res.status == Status.completed) {
      Responses ress = res.data;
      if (ress.status == 1) {
        MerchantModel model = MerchantModel.fromJson({
          "status": ress.status,
          "message": ress.message,
          "merchants": ress.data,
          "pagination": ress.pagination
        });

        if (model.merchants.isNotEmpty) {
          merchantList.addAll(model.merchants); // Append new banks to the list
          merchantcurrentPage++; // Move to next page
          print("Fetching more merchnats... Page: $pageNumber");
          print("Total merchants loaded: ${merchantList.length}");
        } else {
          merchanthasMoreData = false; // No more data to load
        }
      }
    } else {
      UIHelper.showMySnak(
          title: "ERROR", message: res.message.toString(), isError: true);
    }

    merchantisLoadingMore = false;
    notifyListeners();
  }

  easyLoadingStart({status}) {
    EasyLoading.show(
      indicator:
          Lottie.asset("images/buzdysplash.json", width: 150, height: 150),
    );
    notifyListeners();
  }

  easyLoadingStop() {
    EasyLoading.dismiss();
    notifyListeners();
  }

  savetoken({token}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
    print("token saved successfully: $token");
  }
}
