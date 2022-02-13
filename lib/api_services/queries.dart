class GrpahQLQuery {

  //----Method to return graphQL query for fetching all countries---------------------//
  String getCountries() {
    return """
    {
      countries {
        code
        name
        native
        phone
        continent {
          code
          name
        }
        currency
        languages {
          code
          name
          native
          rtl
        }
        emoji
        emojiU
      }
    }
    """;
  }

//----Method to return graphQL query for fetch/search country using Country Code---------------------//
  getCountryDetails(String countryCode) {
    return """
     {
      country(code: "$countryCode") {
        name
        native
        capital
        emoji
        currency
        languages {
          code
          name
        }
      }
    }
    """;
  }

//----Method to return graphQL query for fetching all languages---------------------//
  getLanguages() {
    return """
    {
      languages {
        code
        name
        native
        rtl
      }
    }
    """;
  }

  String getCountryByCode(String code) {
    return """
    {
      country(code:"$code") {
        code
        name
        native
        phone
        continent {
          code
          name
        }
        currency
        languages {
          code
          name
          native
          rtl
        }
        emoji
        emojiU
      }
    }
    """;
  }
}
