abstract class FavoriteEvent {}

class LoadFavorites extends FavoriteEvent {}

class AddFavorite extends FavoriteEvent {
  final int id;
  AddFavorite(this.id);
}

class RemoveFavorite extends FavoriteEvent {
  final int id;
  RemoveFavorite(this.id);
}
