import 'package:equatable/equatable.dart';

class WifiControlModel extends Equatable {
  final int id;
  final String url;
  const WifiControlModel({
    required this.id,
    required this.url,
  });

  @override
  List<Object> get props => [id, url];

  @override
  bool get stringify => true;

  WifiControlModel copyWith({
    int? id,
    String? url,
  }) {
    return WifiControlModel(
      id: id ?? this.id,
      url: url ?? this.url,
    );
  }
}
