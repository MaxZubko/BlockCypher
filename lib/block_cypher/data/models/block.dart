import 'package:equatable/equatable.dart';

class BlockModel extends Equatable {
  final int height;
  final String hash;
  final int time;

  const BlockModel(
      {required this.height, required this.hash, required this.time});

  @override
  List<Object?> get props => [height, hash, time];

  factory BlockModel.fromJson(Map<String, dynamic> json) {
    return BlockModel(
      height: json['height'],
      hash: json['hash'],
      time: json['time'],
      // time: DateTime.parse(json['time'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'hash': hash,
      'time': time,
    };
  }
}
