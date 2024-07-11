
import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/account/widgets/single_product.dart';
import 'package:amazon/features/admin/services/admin_services.dart';
import 'package:amazon/features/order_details/screens/order_details_screen.dart';
import 'package:amazon/models/order.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  List<Order>? orderList;

  AdminServices adminServices = AdminServices();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllOrders();
  }




  void fetchAllOrders() async{
    orderList = await adminServices.fetchAllOrders(context);
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    return orderList == null ? 
    const Loader() :  
      GridView.builder(
        itemCount: orderList!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
       itemBuilder: (context, index){

        final orderData = orderList![index];
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(
              context, OrderDetailScreen.routeName, 
              arguments: orderData,
            );
          },
          child: SingleProduct(
            image: orderData.products[0].images[0]),
        );
       });
  }
}