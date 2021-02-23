class FavoriteModel {
  final String idFavorite;
  final String emailFavorite;
  final String statusFavorite;

  FavoriteModel({
    this.idFavorite,
    this.emailFavorite,
    this.statusFavorite,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> object) {
    return FavoriteModel(
      idFavorite: object["favorite_id"],
      emailFavorite: object["favorite_email"],
      statusFavorite: object["status"],
    );
  }

  // static Future<FavoriteModel> connectToAPI(String parentNimMhs) async {
  //   var apiResult = await http.get(BaseUrl.dataPersonalDataURl + parentNimMhs);
  //   var jsonObject = jsonDecode(apiResult.body);

  //   return FavoriteModel.fromJson(jsonObject);
  // }
}
