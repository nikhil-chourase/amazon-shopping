

import 'package:amazon/common/widgets/loader.dart';
import 'package:amazon/features/admin/model/sales.dart';
import 'package:amazon/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {

  AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEarnings();

  }


  getEarnings() async{
    var earningData = await adminServices.getEarnigs(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {
    });

  }


  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null ? 
    const Loader(): 
      Column(
        children: [
          Text(
                '\$$totalSales',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
        ],

      );
  }
}