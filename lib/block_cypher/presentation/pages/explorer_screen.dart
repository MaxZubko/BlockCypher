import 'package:block_cypher/block_cypher/bloc/btm_nav_bar_cubit/btm_nav_bar_cubit.dart';
import 'package:block_cypher/block_cypher/data/datasources/block_remote.dart';
import 'package:block_cypher/block_cypher/data/models/block.dart';
import 'package:block_cypher/firebase_auth/bloc/auth_bloc.dart';
import 'package:block_cypher/firebase_auth/bloc/auth_event.dart';
import 'package:block_cypher/firebase_auth/bloc/auth_state.dart';
import 'package:block_cypher/firebase_auth/presentation/singIn/sing_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorerScreen extends StatefulWidget {
  const ExplorerScreen({Key? key}) : super(key: key);

  @override
  _ExplorerScreenState createState() => _ExplorerScreenState();
}

class _ExplorerScreenState extends State<ExplorerScreen> {
  late Future<List<BlockModel>> futureBlock;

  @override
  void initState() {
    final timeNow = DateTime.now().millisecondsSinceEpoch;
    print(timeNow);
    super.initState();
    futureBlock = BlockRemoteDataSource().getBlocks(timeNow);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              const Positioned(
                child: Image(
                  image: AssetImage('assets/images/blockchain.jpg'),
                ),
              ),
              Positioned(
                left: 70,
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/bitcoin.svg.png'),
                              fit: BoxFit.fill)),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'Bitcoin \nExplorer',
                      style: TextStyle(color: Colors.white, fontSize: 45.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _recentBlockTable(),
                  const SizedBox(height: 25),
                  _latestTransactions(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _recentBlockTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Blocks',
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(
          height: 7,
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder<List<BlockModel>>(
              future: futureBlock,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DataTable(
                      columns: const [
                        DataColumn(label: Text('Height')),
                        DataColumn(label: Text('Hash')),
                        DataColumn(label: Text('Time')),
                      ],
                      rows: List.generate(5, (index) {
                        return DataRow(cells: [
                          DataCell(Text('${snapshot.data![index].height}')),
                          DataCell(Text(snapshot.data![index].hash)),
                          DataCell(Text('${snapshot.data![index].time}')),
                        ]);
                      }));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ))
      ],
    );
  }

  Column _latestTransactions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Latest Transactions',
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(
          height: 7,
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(
                    label: Text(
                  'Height',
                )),
                DataColumn(label: Text('Transaction Hash')),
                DataColumn(label: Text('BTC')),
                DataColumn(label: Text('Time')),
                DataColumn(label: Text('Miner Preference')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Container(
                    child: Text('1'),
                  )),
                  DataCell(Container(
                    child: Text('2'),
                  )),
                  DataCell(Container(
                    child: Text('3'),
                  )),
                  DataCell(Container(
                    child: Text('4'),
                  )),
                  DataCell(Container(
                    child: Text('5'),
                  )),
                ])
              ],
            ))
      ],
    );
  }
}
