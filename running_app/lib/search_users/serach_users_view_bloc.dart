import 'package:core/di/injection_container.dart';
import 'package:domain/entities/search_user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:running_app/search_users/search_users_view_event.dart';
import 'package:running_app/search_users/search_users_view_state.dart';
import 'package:domain/use_cases/search_users_use_case.dart';

class SearchUsersBloc extends Bloc<SearchUsersEvent, SearchUsersState> {
  final _searchUseCase = sl.get<SearchUsersUseCase>();

  SearchUsersBloc() : super(const SearchUsersState()) {
    on<SearchUserEvent>(_handleSearchText);

    on<SearchSuccessfulEvent>(_handleSearchSuccessful);
    on<SearchStatusUpdatedEvent>(_handleSearchStatusUpdated);
    on<ClearSearchEvent>(_handleClearSearch);
    on<ResultSelectedEvent>(_handleResultSelected);
  }

  _handleSearchText(SearchUserEvent event, Emitter<SearchUsersState> emit) {
    if (event.text.isEmpty) {
      _searchUseCase.clear();
      add(SearchStatusUpdatedEvent(SearchStatus.none));
      return;
    }

    add(SearchStatusUpdatedEvent(SearchStatus.started));

    _searchUseCase.search(
        text: event.text, userId: event.userId, onStatusUpdate: _onStatusUpdate, onResult: _onSearchCompleted);
  }

  _handleClearSearch(ClearSearchEvent event, Emitter<SearchUsersState> emit) {
    _searchUseCase.clear();
    emit(state.copyWith(results: [], status: SearchStatus.none));
  }

  _handleSearchSuccessful(SearchSuccessfulEvent event, Emitter<SearchUsersState> emit) =>
      emit(state.copyWith(results: event.results));

  _handleSearchStatusUpdated(SearchStatusUpdatedEvent event, Emitter<SearchUsersState> emit) =>
      emit(state.copyWith(status: event.status));

  _handleResultSelected(ResultSelectedEvent event, Emitter<SearchUsersState> emit) {
    if (event.result != null) {
      emit(state.copyWith(selectedUser: event.result));
    } else {
      emit(state.copyWithNullSelectedLandmark());
    }
  }

  _onSearchCompleted(List<SearchUserEntity> result) {
    if (isClosed) return;

    add(SearchStatusUpdatedEvent(SearchStatus.ended));
    add(SearchSuccessfulEvent(result));
  }

  _onStatusUpdate(SearchStatus status) {
    final s = status;
  }
}