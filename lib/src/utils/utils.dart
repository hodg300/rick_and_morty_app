class Utils{

  static String mapToQueryParams(Map<String, String> params) {
    if (params.isEmpty) return '';

    // Join each key-value pair with '=' and then concatenate pairs with '&'
    return params.entries.map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value)}').join('&');
  }

}