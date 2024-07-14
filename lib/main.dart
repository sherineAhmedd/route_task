import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:recycle_app/ui/product_screen.dart';
import 'blocs/product_cubit.dart';
import 'injection.dart';


void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(
          create: (context) => GetIt.instance<ProductCubit>()..fetchProducts(),
        ),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false,
        title: 'Flutter Task',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProductScreen(),
      ),
    );
  }
}


