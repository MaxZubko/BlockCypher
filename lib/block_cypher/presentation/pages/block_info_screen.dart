import 'package:block_cypher/block_cypher/bloc/block_info_bloc/cubit/blockinfo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlockInfoPage extends StatelessWidget {
  final String hashBlock;
  final String heightBlock;
  const BlockInfoPage(
      {Key? key, required this.hashBlock, required this.heightBlock})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlockinfoCubit blockInfoCubit = BlockinfoCubit.get(context);
    blockInfoCubit.getBlockInfo(hashBlock);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/images/logo.png',
          height: 35,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              _headerImage(),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocBuilder<BlockinfoCubit, BlockInfoState>(
                    builder: (context, state) {
                      if (state is BlockInfoInitialState) {
                        return const Center(child: Text('No data'));
                      }
                      if (state is BlockInfoLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is BlockInfoLoadedState) {
                        final blocksInfoData = state.blockInfo;
                        return Column(
                          children: [
                            _blockInfo(blocksInfoData),
                            const SizedBox(height: 20),
                            const Text(
                              'Advanced Details',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            _blockDetails(blocksInfoData),
                          ],
                        );
                      }
                      if (state is BlockInfoErrorState) {
                        return Center(child: Text(state.error.toString()));
                      }
                      return Container();
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }

  Stack _headerImage() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        const Positioned(
          child: Image(image: AssetImage('assets/images/blockchain.jpg')),
        ),
        Positioned(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/block.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Bitcoin block $heightBlock',
                  style: const TextStyle(color: Colors.white, fontSize: 32),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  hashBlock,
                  style: const TextStyle(color: Colors.white70, fontSize: 20),
                )),
          ]),
        ),
      ],
    );
  }

  Container _blockInfo(blocksInfoData) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Text(
            'Bits'.toUpperCase(),
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 7),
          Text(
            '${blocksInfoData.bits}',
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 7),
          Divider(
            height: 2,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 7),
          Text(
            'Index'.toUpperCase(),
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 7),
          Text(
            '${blocksInfoData.blockIndex}',
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Table _blockDetails(blocksInfoData) {
    return Table(
      border: TableBorder.all(color: Colors.grey.shade400),
      children: [
        TableRow(decoration: BoxDecoration(color: Colors.grey[200]), children: [
          const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Size',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          Padding(
              padding: const EdgeInsets.all(15),
              child: Text('${blocksInfoData.size}')),
        ]),
        TableRow(decoration: BoxDecoration(color: Colors.grey[200]), children: [
          const Padding(
              padding: EdgeInsets.all(15),
              child:
                  Text('Nonce', style: TextStyle(fontWeight: FontWeight.bold))),
          Padding(
              padding: const EdgeInsets.all(15),
              child: Text('${blocksInfoData.nonce}')),
        ]),
      ],
    );
  }
}
