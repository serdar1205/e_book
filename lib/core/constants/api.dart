class ApiEndpoints {
  static const String baseURL = 'https://hapi-books.p.rapidapi.com';
  static const String getMostPopularAuthorsUrl = '$baseURL/top_authors';

  static const String getNominatedBooksUrl = '$baseURL/nominees/romance/2020';
  static const String getAwardedBooksUrl = '$baseURL/top/2021';
  static const String searchBooksByNameUrl = '$baseURL/search/'; //book name
  static const String getWeeklyPopularBooksUrl = '$baseURL/week/horror/10';
  static const String getBookDetailsUrl = '$baseURL/book/'; //id
  static const String getMostPopularBooksUrl = '$baseURL/month/2022/3';
  static const String getAuthorInfoUrl = '$baseURL/author/';

  static const String headerApiKey = 'X-RapidAPI-Key';
  static const String headerApiKeyValue = 'ae7065ca50msha796e0dbda0dd19p112bedjsn2bf6734572d4';
  /// 2'0cddae034dmsh47fc9676b9feb00p16a9fajsn4773f121eaba';

     ///1 'dff14fce89msh3d65c2f80f1e69dp1fd08ajsn2d70882d285d';

  static const String headerApiHost = 'X-RapidAPI-Host';
  static const String headerApiHostValue = 'hapi-books.p.rapidapi.com';
}

class FailureMessageConstants {
  /// Failures message
  static const String databaseFailureMessage = 'Database Failure';
  static const String serverFailureMessage = 'Server Failure';
  static const String connectionFailureMessage = 'Connection Failure';
}
