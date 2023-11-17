import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/helper/form/form_machine_group_create_update.model.dart';
import '../model/model/machine_group/machine_group.model.dart';
import '../model/repository/machine_group.repository.dart';

class MachineGroupState extends Equatable {
  final List<MachineGroupModel> items;
  final AsyncValue<List<MachineGroupModel>?> onGetAll;
  final AsyncValue<MachineGroupModel?> onGetById;
  final AsyncValue<MachineGroupModel?> onCreate;
  final AsyncValue<MachineGroupModel?> onUpdate;
  final AsyncValue<MachineGroupModel?> onDelete;
  const MachineGroupState({
    this.items = const [],
    this.onGetAll = const AsyncData(null),
    this.onGetById = const AsyncData(null),
    this.onCreate = const AsyncData(null),
    this.onUpdate = const AsyncData(null),
    this.onDelete = const AsyncData(null),
  });

  @override
  List<Object> get props {
    return [
      items,
      onGetAll,
      onGetById,
      onCreate,
      onUpdate,
      onDelete,
    ];
  }

  @override
  bool get stringify => true;

  MachineGroupState copyWith({
    List<MachineGroupModel>? items,
    AsyncValue<List<MachineGroupModel>?>? onGetAll,
    AsyncValue<MachineGroupModel?>? onGetById,
    AsyncValue<MachineGroupModel?>? onCreate,
    AsyncValue<MachineGroupModel?>? onUpdate,
    AsyncValue<MachineGroupModel?>? onDelete,
  }) {
    return MachineGroupState(
      items: items ?? this.items,
      onGetAll: onGetAll ?? this.onGetAll,
      onGetById: onGetById ?? this.onGetById,
      onCreate: onCreate ?? this.onCreate,
      onUpdate: onUpdate ?? this.onUpdate,
      onDelete: onDelete ?? this.onDelete,
    );
  }
}

class MachineGroupNotifier extends StateNotifier<MachineGroupState> {
  final MachineGroupRepository repository;
  final String userId;
  MachineGroupNotifier({
    required this.repository,
    required this.userId,
  }) : super(const MachineGroupState());

  Future<MachineGroupState> getAll() async {
    final result = await repository.getAll(userId);
    return result.fold(
      (failure) => state = state.copyWith(
        onGetAll: AsyncError(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(
        onGetAll: AsyncData(data),
        items: [
          ...data,
        ],
      ),
    );
  }

  Future<MachineGroupState> getById({
    required String machineGroupId,
  }) async {
    state = state.copyWith(onGetById: const AsyncLoading());
    final result = await repository.getById(
      userId: userId,
      machineGroupId: machineGroupId,
    );
    return result.fold(
      (failure) => state = state.copyWith(
        onGetById: AsyncError(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(
        onGetById: AsyncData(data),
      ),
    );
  }

  Future<MachineGroupState> create(
    FormMachineGroupCreateOrUpdateModel form,
  ) async {
    state = state.copyWith(onCreate: const AsyncLoading());
    final result = await repository.create(form);
    return result.fold(
      (failure) => state = state.copyWith(
        onCreate: AsyncError(failure.message, StackTrace.current),
      ),
      (data) => state = state.copyWith(
        onCreate: AsyncData(data),
        items: [...state.items, data],
      ),
    );
  }

  Future<MachineGroupState> update(
    String machineGroupId,
    FormMachineGroupCreateOrUpdateModel form,
  ) async {
    state = state.copyWith(onUpdate: const AsyncLoading());
    final result = await repository.update(
      machineGroupId,
      form,
    );
    return result.fold(
      (failure) => state = state.copyWith(
        onUpdate: AsyncError(failure.message, StackTrace.current),
      ),
      (data) {
        return state = state.copyWith(
          onUpdate: AsyncData(data),
          items: [
            for (final item in state.items)
              if (item.id == data.id) data else item
          ],
        );
      },
    );
  }

  Future<MachineGroupState> delete({
    required String machineGroupId,
  }) async {
    state = state.copyWith(onDelete: const AsyncLoading());
    final result = await repository.delete(
      userId: userId,
      machineGroupId: machineGroupId,
    );
    return result.fold(
      (failure) => state = state.copyWith(
        onDelete: AsyncError(failure.message, StackTrace.current),
      ),
      (data) {
        return state = state.copyWith(
          onDelete: AsyncData(data),
          items: state.items.where((item) => item.id != data.id).toList(),
        );
      },
    );
  }
}
