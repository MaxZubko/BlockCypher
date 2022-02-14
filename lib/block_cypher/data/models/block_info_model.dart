import 'package:equatable/equatable.dart';

class BlockInfoModel extends Equatable {
  int? blockIndex;
  int? size;
  int? nonce;
  int? bits;

  BlockInfoModel({this.blockIndex, this.size, this.nonce, this.bits});

  @override
  List<Object?> get props => [blockIndex, size, nonce, bits];

  factory BlockInfoModel.fromJson(Map<String, dynamic> json) {
    return BlockInfoModel(
        blockIndex: json['block_index'],
        size: json['size'],
        nonce: json['nonce'],
        bits: json['bits']);
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['block_index'] = blockIndex;
  //   data['size'] = size;
  //   data['nonce'] = nonce;
  //   data['bits'] = bits;
  //   return data;
  // }
}
