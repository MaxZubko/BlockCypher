import 'package:block_cypher/block_cypher/data/models/block_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BlockRepository {
  // final http.Client client;

  // BlockRemoteDataSource({required this.client});

  Future<List<BlockModel>> getBlocks(timeNow) async {
    final response = await http
        .get(Uri.parse('https://blockchain.info/blocks/$timeNow?format=json'));

    if (response.statusCode == 200) {
      final block = json.decode(response.body);

      return block
          .map<BlockModel>((json) => BlockModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load block');
    }
  }
}
