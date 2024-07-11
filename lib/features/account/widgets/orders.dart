
import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/account/services/account_services.dart';
import 'package:amazon/features/account/widgets/single_product.dart';
import 'package:amazon/features/order_details/screens/order_details_screen.dart';
import 'package:amazon/models/order.dart';
import 'package:flutter/material.dart';



class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  List<Order>? ordersList;
  AccountServices accountServices = AccountServices();

  @override
  void initState() {
    super.initState();
    fetchAllOrders();
  }


  void fetchAllOrders() async{ 
    ordersList = await accountServices.fetchAllOrders(context);
    setState(() {      
    });
  }


  List<String> orders = [
    'https://plus.unsplash.com/premium_photo-1671247953201-2fdc17af6692?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8bWFjYm9va3xlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1482941059634-6bf5a670d7bf?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1593062096033-9a26b09da705?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8ZGVza3xlbnwwfHwwfHx8MA%3D%3D',

  ];

  // void fetchOrders() async {
  //   orders = await accountServices.fetchMyOrders(context: context);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return ordersList == null? const Loader():
        Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ),
                  ),
                ],
              ),
              // display orders
              Container(
                height: 170,
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 20,
                  right: 0,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ordersList!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(
                        //   context,
                        //   OrderDetailScreen.routeName,
                        //   arguments: orders![index],
                        // );
                      },
                      child: GestureDetector(
                        onTap: ()=> Navigator.pushNamed(context, OrderDetailScreen.routeName, arguments: ordersList![index]),
                        child: SingleProduct(
                          image: ordersList![index].products[0].images[0],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}