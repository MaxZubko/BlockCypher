import 'package:block_cypher/block_cypher/bloc/btm_nav_bar_bloc/btm_nav_bar_cubit.dart';
import 'package:block_cypher/block_cypher/bloc/btm_nav_bar_bloc/btm_nav_bar_state.dart';
import 'package:block_cypher/firebase_auth/bloc/auth_bloc.dart';
import 'package:block_cypher/firebase_auth/bloc/auth_event.dart';
import 'package:block_cypher/firebase_auth/bloc/auth_state.dart';
import 'package:block_cypher/firebase_auth/presentation/singIn/sing_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BtmNavBarCubit, BtmNavBarState>(
      listener: (context, state) {},
      builder: (context, state) {
        BtmNavBarCubit btmCubit = BtmNavBarCubit.get(context);
        return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is UnAutthenticated) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const SignIn()),
                    (route) => false);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Image.asset(
                  'assets/images/logo.png',
                  height: 35,
                ),
                centerTitle: false,
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      context.read<AuthBloc>().add(SignOutRequested());
                    },
                  ),
                ],
              ),
              body: btmCubit.screens[btmCubit.bottomNavigationIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: btmCubit.bottomNavigationIndex,
                onTap: (index) {
                  btmCubit.changeIndex(index);
                },
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list), label: 'Block List'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.insert_drive_file_outlined),
                      label: 'Block'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.transfer_within_a_station),
                      label: 'Transactions'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.rotate_right_outlined),
                      label: 'Address'),
                ],
              ),
            ));
      },
    );
  }
}
