import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/product_cubit.dart';

import '../blocs/product_cubit.dart';
import '../blocs/product_cubit.dart';
import '../models/product.dart';
import '../services/product_service.dart';


class ProductScreen extends StatefulWidget {
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}


class _ProductScreenState extends State<ProductScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];


  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterProducts);
    BlocProvider.of<ProductCubit>(context).searchProducts;
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts =  BlocProvider.of<ProductCubit>(context)
          .state.products.where((product) => product.title.toLowerCase().startsWith(query)).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    List<Product> products;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x8CA4CEFF),
        centerTitle: true,
        title: Text('Products'),
        actions: [
           Padding(
             padding: const EdgeInsets.all(10),
             child: IconButton(onPressed: (){

             },
                 icon:Icon(Icons.shopping_cart_sharp,color: Colors.indigoAccent,)),
           )],
      ),

      body:
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'What do your search for?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                prefixIcon: IconButton(onPressed: (){
                  BlocProvider.of<ProductCubit>(context)
                      .searchProducts(_searchController.text);

                }, icon: Icon(Icons.search)),
              ),
              onChanged: (query) {
                BlocProvider.of<ProductCubit>(context)
                    .searchProducts(query);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  final products = _searchController.text.isEmpty
                      ? state.products
                      : _filteredProducts;
                  return GridView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                       return  Stack(
                         alignment:Alignment.bottomRight ,
                         children: [

                           SingleChildScrollView(
                             child: Container(
                               padding: EdgeInsets.all(8),
                               margin: EdgeInsets.all(8),
                               color:Colors.white,
                               child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                                 children: [

                                   IconButton(onPressed: (){

                                   }, icon:
                                   Icon(Icons.favorite_border,color: Colors.indigo,),),
                                   Container( height: 100, // Set a fixed height for the container
                                   width: 100,
                                   child: Image.network(product.thumbnail,
                                     scale:7,
                                     fit: BoxFit.contain,),
                                 ),
                                   Text(product.title,
                                     style: TextStyle(
                                       color: Colors.indigo,
                                     ),),
                                   // Text(product.description.trim(),
                                   //   style: TextStyle(
                                   //     color: Colors.indigo,
                                   //   ),),
                                   Text(product.price.toString(),
                                     style: TextStyle(
                                       color: Colors.indigo,
                                     ),),
                                   Row(
                                     children: [
                                       Text(product.rating.toString(),
                                         style: TextStyle(
                                           color: Colors.indigo,
                                         ),),
                                       Icon(Icons.star,color: CupertinoColors.systemYellow,)
                                     ],
                                   ),
                                 ],
                               ),),
                           ),
                            Container(
                              child: IconButton(onPressed: (){},
                                  icon:Icon(Icons.add,color: Colors.indigo,)),
                            )
                         ],

                       );
                      // Container(
                      //   leading: Image.network(product.thumbnail),
                      //   title: Text(product.title),
                      //   subtitle: Text(product.description),
                      //   trailing: Text('\$${product.price.toString()}'),
                      // );
                    }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  );
                } else if (state is ProductError) {
                  return Center(child: Text(state.message));
                } else {
                  return Center(child: Text('No products found'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
