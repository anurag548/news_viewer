import 'package:get/get.dart';
import 'package:news_viewer/models/favorites.dart';

class FavController extends GetxController {
  var _favorites = {}.obs;

  void addFavorites(Favorites fav) {
    if (_favorites.containsKey(fav)) {
      return;
    }
  }
}
