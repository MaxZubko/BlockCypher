part of 'blocks_cubit.dart';

abstract class BlocksState extends Equatable {
  const BlocksState();

  @override
  List<Object> get props => [];
}

class BlocksInitialState extends BlocksState {
  @override
  List<Object> get props => [];
}

class BlockLoadingState extends BlocksState {
  @override
  List<Object> get props => [];
}

class BlockLoadedState extends BlocksState {
  final List<BlockModel> block;

  const BlockLoadedState(this.block);

  @override
  List<Object> get props => [block];
}

class BlockErrorState extends BlocksState {
  final String error;

  const BlockErrorState(this.error);

  @override
  List<Object> get props => [error];
}
