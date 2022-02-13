import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zp_assignment/common/app_methods.dart';
import 'package:zp_assignment/common/app_strings.dart';
import 'package:http/http.dart' as http;

class Api{
  final JsonDecoder _decoder = const JsonDecoder();
  
  //------------------------post api call---------------------//
  Future<dynamic> post(String url, Map body,BuildContext context) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      bool internetCheck = await checkInternetConnectivity();
      if (internetCheck) {
        return http.post(Uri.parse(url), body: jsonEncode(body), headers: headers).then((http.Response response) {
          final int statusCode = response.statusCode;
          Map responseBody = _decoder.convert(response.body);
          if(statusCode==200){
            return responseBody;
          }else{
            toastMessage(context,responseBody["errors"][0]["message"],"error");
          }
          return null;
        });
      } else {
        toastMessage(context,networkError,"error");
        return;
      }
    } on SocketException {
      toastMessage(context,serverError,"error");
      return;
    }
  }
}