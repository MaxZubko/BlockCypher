import 'package:block_cypher/block_cypher/data/models/block_info_model.dart';
import 'package:block_cypher/block_cypher/data/repositories/block_info_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blockinfo_state.dart';

class BlockinfoCubit extends Cubit<BlockInfoState> {
  final BlockInfoRepository _blockInfoRepository;
  // String hash;

  BlockinfoCubit(this._blockInfoRepository) : super(BlockInfoInitialState());

  static BlockinfoCubit get(context) => BlocProvider.of(context);

  Future<void> getBlockInfo(String hashBlock) async {
    try {
      emit(BlockInfoLoadingState());
      final BlockInfoModel blocksInfo =
          await _blockInfoRepository.getBlockInfo(hashBlock);
      emit(BlockInfoLoadedState(blocksInfo));
    } catch (e) {
      emit(BlockInfoErrorState(e.toString()));
    }
  }
}
