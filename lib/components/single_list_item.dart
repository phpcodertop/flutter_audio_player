import 'package:ebook_app/app_colors.dart';
import 'package:ebook_app/details_page.dart';
import 'package:flutter/material.dart';

class SingleListItem extends StatelessWidget {

  final Map book;

  const SingleListItem({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailsPage(
          book: book
        )));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.tabVarViewColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 2,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Container(
                  height: 120,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(book['img']),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.starColor,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          book['rating'],
                          style: const TextStyle(
                            color: AppColors.starColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      book['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Avenir',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      book['text'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Avenir',
                        fontWeight: FontWeight.bold,
                        color: AppColors.subTitleText,
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 30,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: AppColors.loveColor,
                      ),
                      child: const Text(
                        'Love',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Avenir',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
