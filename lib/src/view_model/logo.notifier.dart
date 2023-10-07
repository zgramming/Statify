import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/logo/logo.model.dart';
import '../model/repository/logo.repository.dart';

class LogoState extends Equatable {
  final LogoModel? item;
  final AsyncValue<LogoModel?> onGetFirstLogo;
  final AsyncValue<LogoModel?> onUpload;
  const LogoState({
    this.item,
    this.onGetFirstLogo = const AsyncValue.loading(),
    this.onUpload = const AsyncValue.loading(),
  });

  @override
  List<Object?> get props => [item, onGetFirstLogo, onUpload];

  @override
  bool get stringify => true;

  LogoState copyWith({
    LogoModel? item,
    AsyncValue<LogoModel?>? onGetFirstLogo,
    AsyncValue<LogoModel?>? onUpload,
  }) {
    return LogoState(
      item: item ?? this.item,
      onGetFirstLogo: onGetFirstLogo ?? this.onGetFirstLogo,
      onUpload: onUpload ?? this.onUpload,
    );
  }
}

class LogoNotifier extends StateNotifier<LogoState> {
  final LogoRepository repository;
  LogoNotifier({
    required this.repository,
  }) : super(const LogoState()) {
    getFirstLogo();
  }

  Future<LogoState> getFirstLogo({
    bool invalidate = true,
  }) async {
    if (invalidate) {
      state = state.copyWith(
        onGetFirstLogo: const AsyncValue.loading(),
      );
    }
    final result = await repository.getFirstLogo();

    final fold = result.fold(
      (l) => state = state.copyWith(
        onGetFirstLogo: AsyncValue.error(l.message, StackTrace.current),
        item: null,
      ),
      (r) => state = state.copyWith(
        item: r,
        onGetFirstLogo: AsyncValue.data(r),
      ),
    );

    return fold;
  }

  Future<void> upload(Uint8List file) async {
    state = state.copyWith(
      onUpload: const AsyncValue.loading(),
    );
    final result = await repository.upload(file);
    state = state.copyWith(
      onUpload: result.fold(
        (l) {
          state = state.copyWith(
            item: null,
            onUpload: AsyncValue.error(l.message, StackTrace.current),
          );
          return null;
        },
        (r) {
          state = state.copyWith(
            item: r,
            onUpload: AsyncValue.data(r),
          );
          return null;
        },
      ),
    );
  }
}
