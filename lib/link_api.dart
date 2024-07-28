class AppLink {
  //real phone
  static const String baseUrl =
      'https://springboot-pharmacy-api-production.up.railway.app/api/v1';
  //emulator
  // static const String baseUrl = 'http://10.0.2.2:8080/api/v1';

  // http://localhost:8080/api/v1/auth/login
  // =======================Auth Url==============================
  static const String baseAuth = '$baseUrl/auth';
  static const String registerAdmin = '$baseAuth/register_admin';
  static const String registerUser = '$baseAuth/register_user';
  static const String login = '$baseAuth/login';
  static const String refreshToken = '$baseAuth/refresh';
  // static const String logout = '$baseAuth/logout';

  //========================Admin Url============================
  static const String baseAdmin = '$baseUrl/admin';
  static const String category = '$baseAdmin/category';
  static const String drug = '$baseAdmin/drug';
  static const String orders = '$baseAdmin/orders';

//========================User Url============================
  static const String baseUser = '$baseUrl/user';
  static const String admins = '$baseUser/admins';
  static const String userDrug = '$baseUser/drug';
  static const String userOrders = '$baseUser/orders';
  static const String favorites = '$baseUser/favorites';
  static const String image = '$baseUser/image';
}
// http://127.0.0.1:8000/api/auth/register
