// import 'package:block_cypher/block_cypher/core/error/exception.dart';
// import 'package:block_cypher/block_cypher/data/models/block_model.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// abstract class BlockRemoteDataSource {
//   Future<List<BlockModel>> getBlocks(DateTime timeNow);
// }

// class BlockRemoteDataSourceImpl implements BlockRemoteDataSource {
//   final http.Client client;

//   BlockRemoteDataSourceImpl({required this.client});

//   @override
//   Future<List<BlockModel>> getBlocks(DateTime timeNow) async {
//     final response = await client.get(
//         Uri.parse('//https://blockchain.info/blocks/$timeNow?format=json'));

//     if (response.statusCode == 200) {

//       final block = json.decode(response.body);
      
//       return (block['blocks'] as List)
//           .map((block) => BlockModel.fromJson(block))
//           .toList();
//     } else {
//       throw ServerException();
//     }
//   }
// }
