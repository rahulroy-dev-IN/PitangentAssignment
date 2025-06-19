import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pitangent_assignment/global/network/shared_pref/pref_strings.dart';
import 'package:pitangent_assignment/global/network/shared_pref/preference_connector.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<LoadFavorites>((event, emit) async {
      final ids = await _loadFavoritesFromPrefs();
      emit(FavoriteLoaded(ids));
    });

    on<AddFavorite>((event, emit) async {
      final current = state is FavoriteLoaded
          ? (state as FavoriteLoaded).favorites
          : [];
      if (!current.contains(event.id)) {
        final updated = List<int>.from(current)..add(event.id);
        final ids = await saveFavoritesToPrefs(updated);
        emit(FavoriteLoaded(ids));
      }
    });

    on<RemoveFavorite>((event, emit) async {
      final current = state is FavoriteLoaded
          ? (state as FavoriteLoaded).favorites
          : [];
      final updated = List<int>.from(current)..remove(event.id);
      final ids = await saveFavoritesToPrefs(updated);
      emit(FavoriteLoaded(ids));
    });
  }

  Future<List<int>> _loadFavoritesFromPrefs() async {
    final list =
        await PreferenceConnector().getStringList(PrefStrings.favIds) ?? [];
    return list.map((l) => int.tryParse(l) ?? -1).toList();
  }

  Future<List<int>> saveFavoritesToPrefs(List<int> ids) async {
    final stringList = ids.map((e) => e.toString()).toList();
    await PreferenceConnector().setStringList(PrefStrings.favIds, stringList);
    return ids;
  }
}
