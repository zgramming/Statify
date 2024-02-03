import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/lda_setting_sync_state.model.dart';

class CustomStateProvider {
  // Seharusnya nanti custom_form_provider.dart ini dihapus
  // dan diganti dengan custom_state_provider.dart
  // Terutama state yang berhubungan dengan LDA, akan dimerge menjadi satu yaitu machineConfigFormState

  // Shareable state
  static final ldaSettingSyncState =
      StateProvider<List<LDASettingSyncStateModel>>(
    (ref) => [],
  );
}
