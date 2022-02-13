import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:zp_assignment/common/app_strings.dart';
import 'package:zp_assignment/models/country.dart';

//--------checks internet connectivity in devices before making any request--------------//
Future<bool> checkInternetConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

//----Common method to show message to user for success, error , or any information---------------------//
toastMessage(context, String message, String type) {
  showTopSnackBar(
    context,
    getMessage(type, message),
  );
}

//----Method to return Snackbar Widget for success, error , or any information---------------------//
Widget getMessage(String type, String message) {
  if (type == success) {
    return CustomSnackBar.success(
      message: message,
    );
  }if (type == error) {
    return CustomSnackBar.error(
      message: message,
    );
  }else{
    return CustomSnackBar.info(
      message: message,
    );
  }
}

//----Method to concat country name and continent and return as string---------------------//
String getNameAndContinent(Country country) {
  String finalString = country.name ?? '';
  if (country.continent != null && country.continent?.name != null) {
    finalString = finalString + " , (" + (country.continent?.name)! + ")";
  }
  return finalString;
}
