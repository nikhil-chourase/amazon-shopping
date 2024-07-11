

import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/account/widgets/single_product.dart';
import 'package:amazon/features/admin/screens/add_product_screen.dart';
import 'package:amazon/features/admin/services/admin_services.dart';
import 'package:amazon/models/product.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {


  AdminServices adminServices = AdminServices();
  List<Product>? productList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProducts();

  }

  fetchAllProducts() async{
    productList =  await adminServices.fetchAllProducts(context);
    setState(() {

    });
  }


  void deleteProduct(Product product, int index){
    adminServices.deleteProduct(
      context: context,
      product: product, 
      onSuccess: (){
        productList!.removeAt(index);
        setState(() {
        });
      }
    );
  }


  void navigateToProduct(){
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }


  @override
  Widget build(BuildContext context) {
    return productList == null? const Loader() : Scaffold(

      body: GridView.builder(
        itemCount: productList!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
        itemBuilder: (context,index){

          final productData = productList![index];

          return Column(
            children: [
              SizedBox(
                height: 140,
                child: SingleProduct(
                  image: productData.images[0]
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      productData.name, 
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  IconButton(
                    onPressed: () => deleteProduct( productData, index),
                     icon: const Icon(
                      Icons.delete_outline
                    ),
                  ),
                ],
              )
            ],
          );

        }),

      floatingActionButton: FloatingActionButton(
        backgroundColor: GlobalVariables.selectedNavBarColor,
        onPressed: navigateToProduct,
        
        child: Icon(Icons.add),
        tooltip: 'add a product',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );

  }
}