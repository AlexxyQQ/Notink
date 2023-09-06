class ApiEndpoints {
  /// The code snippet is defining static constants for an API endpoint configuration in Dart for api request.
  static const String baseURL = "http://192.168.1.65:3001/api";
  static const String baseImageUrl = 'http://192.168.1.65:3001/';
  static const String socketURL = "http://localhost:3002";
  static const Map<String, dynamic> defaultHeaders = {
    'apisecret': "Apple",
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
  static const int connectionTimeout = 5000;
  static const int receiveTimeout = 60000;

  // Endpoints
  static const String baseRoute = "/";
  static const String loginWithTokenRoute = "/users/loginWithToken";
  static const String loginRoute = "/users/login";
  static const String signupRoute = "/users/signup";
  static const String uploadProfilePicRoute = "/users/uploadProfilePic";
  static const String deleteUserRoute = "/users/deleteUser";
}
