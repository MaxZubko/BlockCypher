import 'package:block_cypher/block_cypher/bloc/btm_nav_bar_bloc/btm_nav_bar_state.dart';
import 'package:block_cypher/block_cypher/presentation/pages/address_screen.dart';
import 'package:block_cypher/block_cypher/presentation/pages/block_list_screen.dart';
import 'package:block_cypher/block_cypher/presentation/pages/blocks_screen.dart';
import 'package:block_cypher/block_cypher/presentation/pages/explorer_screen.dart';
import 'package:block_cypher/block_cypher/presentation/pages/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BtmNavBarCubit extends Cubit<BtmNavBarState> {
  BtmNavBarCubit() : super(InitialState());

  static BtmNavBarCubit get(context) => BlocProvider.of(context);

  int bottomNavigationIndex = 0;
  List<Widget> screens = [
    const ExplorerScreen(),
    const BlockListPage(),
    const BlockPage(),
    const TransactionsPage(),
    const AddressPage(),
  ];

  void changeIndex(int index) {
    bottomNavigationIndex = index;
    emit(ChangeBottomNavBarState());
  }
}
