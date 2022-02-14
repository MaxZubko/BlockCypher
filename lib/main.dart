import 'package:block_cypher/block_cypher/bloc/block_info_bloc/cubit/blockinfo_cubit.dart';
import 'package:block_cypher/block_cypher/bloc/btm_nav_bar_bloc/btm_nav_bar_cubit.dart';
import 'package:block_cypher/block_cypher/bloc/explorer_bloc/cubit/blocks_cubit.dart';
import 'package:block_cypher/block_cypher/data/repositories/block_info_repository.dart';
import 'package:block_cypher/block_cypher/data/repositories/block_repository.dart';
import 'package:block_cypher/block_cypher/presentation/pages/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_auth/bloc/auth_bloc.dart';
import 'firebase_auth/data/repositories/auth_repository.dart';
import 'firebase_auth/presentation/singIn/sing_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => AuthRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(
                  authRepository:
                      RepositoryProvider.of<AuthRepository>(context)),
            ),
            BlocProvider<BtmNavBarCubit>(create: (context) => BtmNavBarCubit()),
            BlocProvider<BlocksCubit>(
              create: (context) => BlocksCubit(BlockRepository()),
            ),
            BlocProvider<BlockinfoCubit>(
              create: (context) => BlockinfoCubit(BlockInfoRepository()),
            )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const HomeScreen();
                }
                return const SignIn();
              },
            ),
          ),
        ));
  }
}
