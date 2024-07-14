import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/product_cubit.dart';


class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
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
                     Icon(Icons.add,color: Colors.indigo,),
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
    );
  }
}
