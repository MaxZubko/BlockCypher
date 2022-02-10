import 'package:block_cypher/block_cypher/data/models/block.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BlockRemoteDataSource {
  // final http.Client client;
  // final int timeNow = DateTime.now().microsecondsSinceEpoch * 1000;
  // print(timeNow);

  // BlockRemoteDataSource({required this.client});

  Future<List<BlockModel>> getBlocks(timeNow) async {
    final response = await http
        .get(Uri.parse('https://blockchain.info/blocks/$timeNow?format=json'));

    if (response.statusCode == 200) {
      final block = json.decode(response.body);

      return block
          .map<BlockModel>((json) => BlockModel.fromJson(json))
          .toList();
      // return (block['blocks'] as List)
      //     .map((block) => BlockModel.fromJson(block))
      //     .toList();
    } else {
      throw Exception();
    }
  }
}
