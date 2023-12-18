import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final double rating;

  const RatingStar({
    super.key,
    this.rating = -1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(children: [
        const Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.star,
            color: Colors.amber,
            size: 50,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(rating == -1 ? '-' : rating.toString()),
        ),
      ]),
    );
  }
}
