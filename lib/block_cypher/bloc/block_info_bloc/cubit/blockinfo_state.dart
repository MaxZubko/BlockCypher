part of 'blockinfo_cubit.dart';

abstract class BlockInfoState extends Equatable {
  const BlockInfoState();

  @override
  List<Object> get props => [];
}

class BlockInfoInitialState extends BlockInfoState {
  @override
  List<Object> get props => [];
}

class BlockInfoLoadingState extends BlockInfoState {
  @override
  List<Object> get props => [];
}

class BlockInfoLoadedState extends BlockInfoState {
  final BlockInfoModel blockInfo;

  const BlockInfoLoadedState(this.blockInfo);

  @override
  List<Object> get props => [blockInfo];
}

class BlockInfoErrorState extends BlockInfoState {
  final String error;

  const BlockInfoErrorState(this.error);

  @override
  List<Object> get props => [error];
}
