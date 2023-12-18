import 'package:flutter/material.dart';
import 'package:ludoteca/1_domain/entities/full_item.dart';

class CollectionItemDetailLoaded extends StatelessWidget {
  final FullItem itemDetail;
  const CollectionItemDetailLoaded({super.key, required this.itemDetail});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        color: Colors.black54,
        child: Column(
          children: [
            SizedBox(
              height: height / 3,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(itemDetail.imageUrl),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 50,
                            height: 50,
                            child: Stack(children: [
                              Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 50,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text('8'),
                              ),
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              itemDetail.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                          itemDetail.longDescription ?? 'itemDetail.description'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
