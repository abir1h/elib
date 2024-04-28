class ApiCredential {
  const ApiCredential._();

  // static String baseUrl = "http://103.209.40.89:82/api/elib/mobile/mobile-app";
  static String baseUrl = "http://103.209.40.89/book-service/api/mobile";
  static String apiKey = "";

  static String getEMISLink = "http://103.209.40.89:81/api/auth/dev/emis-link";
  static String getToken = "http://103.209.40.89:81/api/auth/dev/emis-auth";
  static String refreshToken = "/auth/dev/token/refresh";
  static String userProfile = "http://103.209.40.89:70/api/clms/dev/profile";

  static String getCategories = "/categories";
  static String getCategoryWithBook = "/category-book";
  static String getBooks = "/books";
  static String getBookDetails = "/book-details";
  static String bookmarkBook = "/bookmark";
  static String popularBooks = "/category-popular?page=";
  static String getBookmarkBooks = "/all-bookmarks";
  static String bookCountUser = "/book-user-count";
  static String downloadCountUser = "/book-download-count";
  static String globalSearch = "/book-search?search=";

  static String categoryDetailsById = "/category/details/";

  static String getNoteBooks = "/book-notes";
  static String noteBook = "/book-note";
  // static String noteBookUpdate = "/note-books/";
  // static String noteBookDelete = "/note-books/";

  static String bookRequest = "/book-requests";
  static String bookViewDownloadReport = "/book-view-download-report";
  static String getAuthors = "/authors";
  static String getBookByAuthors = "/authors/books";
  static String getBookByTags = "/tags/books";
  static String userProgressCount = "/users/progress";
  static String userReadBooks = "/users/book/read";
  static String getHome = "/home";
}
