abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<int> favorites;
  FavoriteLoaded(this.favorites);
}
