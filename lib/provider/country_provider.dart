import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zp_assignment/api_services/api.dart';
import 'package:zp_assignment/api_services/queries.dart';
import 'package:zp_assignment/common/app_methods.dart';
import 'package:zp_assignment/common/app_strings.dart';
import 'package:zp_assignment/models/country.dart';

class CountryProviders extends ChangeNotifier {
  Api api = Api();
  GrpahQLQuery grpahQLQuery = GrpahQLQuery();
  List<Country> mainCountriesList = [];
  List<Country> countries = [];
  List<Languages> languages = [];
  bool isLoading = false;
  List<Languages> filterlanguages = [];
  bool searchEnabled = false;

  get isSearchEnabled => searchEnabled;
  get getCountries => countries;
  get isloading => isLoading;
  get getFilterlanguages => filterlanguages;

  setSearchEnabled() {
    searchEnabled = !searchEnabled;
    if (!searchEnabled) {
      resetCountryList();
    }
    notifyListeners();
  }

  setFilterlanguages(List<Languages> filterlanguagesValues) {
    filterlanguages = filterlanguagesValues;
    notifyListeners();
  }

  setLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  filterCountriesByLang() {
    countries = filterlanguages.isNotEmpty ? [] : mainCountriesList;
    notifyListeners();
    for (var element in mainCountriesList) {
      for (var element1 in element.languages!) {
        if (filterlanguages.any((element3) => element3.code == element1.code)) {
          countries.add(element);
        }
      }
    }
    notifyListeners();
  }

  resetCountryList() {
    countries = mainCountriesList;
    notifyListeners();
  }

  Future fetchCountryList(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    List<Country> tempList = [];
    try {
      Map paramBody = {"query": grpahQLQuery.getCountries()};
      dynamic result = await api.post(graphqlEndpoint, paramBody, context);
      if (result != null && result["data"] != null) {
        result["data"]["countries"].forEach((v) {
          tempList.add(Country.fromJson(v));
        });
      }
      tempList.sort((a, b) {
        return (a.name ?? "")
            .toLowerCase()
            .compareTo((b.name ?? "").toLowerCase());
      });
      mainCountriesList = tempList;
      countries = tempList;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      isLoading = false;
      notifyListeners();
    }
    fetchLanguages(context);
  }

  fetchLanguages(context) async {
    try {
      Map paramBody = {"query": grpahQLQuery.getLanguages()};
      dynamic result = await api.post(graphqlEndpoint, paramBody, context);
      if (result != null && result["data"] != null) {
        result["data"]["languages"].forEach((v) {
          languages.add(Languages.fromJson(v));
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    notifyListeners();
  }

  searchCountryByCountryCode(String text, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    countries = [];
    try {
      Map paramBody = {
        "query": grpahQLQuery.getCountryByCode(text.toUpperCase())
      };
      dynamic result = await api.post(graphqlEndpoint, paramBody, context);
      if (result != null &&
          result["data"] != null &&
          result["data"]["country"] != null) {
        countries.add(Country.fromJson(result["data"]["country"]));
      } else {
        toastMessage(context, noCountryFound, "error");
      }
      countries.sort((a, b) {
        return (a.name ?? "")
            .toLowerCase()
            .compareTo((b.name ?? "").toLowerCase());
      });
      isLoading = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      isLoading = false;
      notifyListeners();
    }
  }
}
