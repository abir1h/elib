class ApiCredential {
  const ApiCredential._();

  static String baseUrl = "http://103.209.40.89:82/api/elib/mobile/mobile-app";
  static String apiKey = "";

  static String getEMISLink = "http://103.209.40.89:81/api/auth/dev/emis-link";
  static String getToken = "http://103.209.40.89:81/api/auth/dev/token";
  static String refreshToken = "/auth/dev/token/refresh";
  static String userProfile = "http://103.209.40.89/api/clms/dev/profile";

  static String getCategories = "/category";
  static String getCategoryWithBook = "/category-book";
  static String getBooks = "/books";
  static String getBookDetails = "/book-details";
  static String bookmarkBook = "/boorkmark-book";
  static String popularBooks = "/category-popular?page=";
  static String getBookmarkBooks = "/all-boorkmark";
  static String bookCountUser = "/book-count-user";
  static String downloadCountUser = "/book-download-count";
  static String globalSearch = "/global-search?search=";

  static String categoryDetailsById = "/category/details/";

  static String getBookRequests = "/book-requests?pagination=";
  static String bookRequest = "/book-requests";
  static String bookViewDownloadReport = "/book-view-download-report";

}
