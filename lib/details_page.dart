import 'package:audioplayers/audioplayers.dart';
import 'package:ebook_app/app_colors.dart';
import 'package:ebook_app/components/audio_file.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'books_provider.dart';

class DetailsPage extends StatefulWidget {
  final Map book;
  final bool startPlay;

  const DetailsPage({super.key, required this.book, this.startPlay = false});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late AudioPlayer advancedPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    advancedPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {


    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return InheritedProvider<BooksProvider>(

      create: (_) => BooksProvider(),
      builder: (context, cd) {
        List books = context.watch<BooksProvider>().books;
        return Scaffold(
            backgroundColor: AppColors.audioBluishBackground,
            body: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: screenHeight / 3,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.audioBlueBackground,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 5,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        advancedPlayer.stop();
                        Navigator.of(context).pop();
                      },
                    ),
                    actions: const [
                      Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.2,
                  right: 0,
                  left: 0,
                  height: screenHeight * 0.36,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.1,
                        ),
                        Text(
                          widget.book['title'],
                          style: const TextStyle(
                            fontSize: 30,
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          widget.book['text'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontFamily: 'Avenir',
                          ),
                        ),

                        // audio player goes here
                        AudioFile(
                            advancedPlayer: advancedPlayer,
                            book: widget.book,
                            startPlay: widget.startPlay),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.12,
                  left: (screenWidth - 150) / 2,
                  right: (screenWidth - 150) / 2,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 5),
                      color: AppColors.audioGreyBackground,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(widget.book['img']),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.6,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Play Next',
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            height: 200,
                            child: Row(
                              children: [
                                for(final book in books) GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsPage(book: book),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 200,
                                    width: screenWidth,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      image: DecorationImage(
                                        image: AssetImage(book['img']),
                                        fit: BoxFit.fill,
                                      ),
                                      color: Colors.black54,
                                    ),
                                    child: Center(
                                      child: Text(
                                        book['title'],
                                        style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Avenir',
                                          color: Colors.blue,
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
      }
    );

  }
}
