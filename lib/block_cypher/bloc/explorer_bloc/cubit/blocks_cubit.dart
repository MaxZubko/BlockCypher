import 'package:bloc/bloc.dart';
import 'package:block_cypher/block_cypher/data/models/block_model.dart';
import 'package:block_cypher/block_cypher/data/repositories/block_repository.dart';
import 'package:equatable/equatable.dart';

part 'blocks_state.dart';

class BlocksCubit extends Cubit<BlocksState> {
  final BlockRepository _blockRepository;

  BlocksCubit(this._blockRepository) : super(BlocksInitialState()) {
    getBlocks();
  }

  void getBlocks() async {
    try {
      emit(BlockLoadingState());
      final timeNow = DateTime.now().millisecondsSinceEpoch;
      final blocks = await _blockRepository.getBlocks(timeNow);
      emit(BlockLoadedState(blocks));
    } catch (e) {
      emit(BlockErrorState(e.toString()));
    }
  }
}
