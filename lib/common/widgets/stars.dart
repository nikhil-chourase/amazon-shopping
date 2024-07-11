

import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  const Stars({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemSize: 15,
      itemCount: 5,
      rating: rating,
      itemBuilder: (BuildContext context,_) { 
        return const Icon(Icons.star, color: GlobalVariables.secondaryColor,);
       },

    );
  }
}