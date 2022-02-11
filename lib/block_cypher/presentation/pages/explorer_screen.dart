import 'package:block_cypher/block_cypher/bloc/explorer_bloc/cubit/blocks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorerScreen extends StatelessWidget {
  const ExplorerScreen({Key? key}) : super(key: key);

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
            child: BlocBuilder<BlocksCubit, BlocksState>(
              builder: (context, state) {
                if (state is BlockLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is BlockLoadedState) {
                  final blocksData = state.block;

                  return DataTable(
                      columns: const [
                        DataColumn(label: Text('Height')),
                        DataColumn(label: Text('Hash')),
                        DataColumn(label: Text('Time')),
                      ],
                      rows: List.generate(5, (index) {
                        return DataRow(cells: [
                          DataCell(Text('${blocksData[index].height}')),
                          DataCell(Text(blocksData[index].hash)),
                          DataCell(Text('${blocksData[index].time}')),
                        ]);
                      }));
                }
                if (state is BlockErrorState) {
                  return Center(child: Text(state.error.toString()));
                }
                return Container();
              },
            )),
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
