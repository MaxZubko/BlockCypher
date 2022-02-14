import 'package:block_cypher/block_cypher/data/models/block_info_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BlockInfoRepository {
  Future<BlockInfoModel> getBlockInfo(String hashBlock) async {
    final response = await http
        .get(Uri.parse('https://blockchain.info/rawblock/$hashBlock'));

    if (response.statusCode == 200) {
      return BlockInfoModel.fromJson(jsonDecode(response.body));
      // final blockInfo = json.decode(response.body);

      // return blockInfo<BlockInfoModel>((json) => BlockInfoModel.fromJson(json))
      //     .toList();
    } else {
      throw Exception('Failed to load block-info');
    }
  }
}
