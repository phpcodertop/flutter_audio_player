import 'package:flutter/material.dart';

class PopularBooks extends StatelessWidget {
  final List books;

  const PopularBooks({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                'Popular Books',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 180,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: -20,
                child: SizedBox(
                  height: 180,
                  child: PageView.builder(
                    controller: PageController(viewportFraction: 0.8),
                    itemCount: books.length,
                    itemBuilder: (context, i) {
                      return Container(
                        height: 180,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage(books[i]['img']),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
