import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:ebook_app/books_provider.dart';
import 'package:ebook_app/details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  final Map book;
  final bool startPlay;

  const AudioFile(
      {super.key, required this.advancedPlayer, required this.book, this.startPlay = false});

  @override
  State<AudioFile> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioFile> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  List books = [];

  String path = '';

  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;
  bool isRepeat = false;
  Color color = Colors.black;

  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];


  @override
  void initState() {
    super.initState();
    //readData();

    path = widget.book['audio'];

    widget.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });

    widget.advancedPlayer.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    widget.advancedPlayer.setSourceUrl(path);

    if(widget.startPlay) {
      widget.advancedPlayer.play(UrlSource(path));
    }

    widget.advancedPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _position = const Duration(seconds: 0);
        isPlaying = false;
        isRepeat = false;
      });
    });
  }

  Widget btnStart() {
    return IconButton(
      // padding: const EdgeInsets.only(bottom: 10),
      onPressed: () async {
        await widget.advancedPlayer.setPlaybackRate(1);
        if (isPlaying == true) {
          widget.advancedPlayer.pause();
          setState(() {
            isPaused = true;
            isPlaying = false;
          });
        } else {
          widget.advancedPlayer.play(UrlSource(path), volume: 100.0);
          setState(() {
            isPaused = false;
            isPlaying = true;
          });
        }
      },
      icon: isPlaying
          ? Icon(
              _icons[1],
              size: 50,
              color: Colors.blue,
            )
          : Icon(
              _icons[0],
              size: 50,
              color: Colors.blue,
            ),
    );
  }

  Widget slider() {
    return Slider(
      activeColor: Colors.red,
      inactiveColor: Colors.grey,
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {
          changeToSeconds(value.toInt());
          value = value;
        });
      },
    );
  }

  void changeToSeconds(int seconds) {
    Duration newDuration = Duration(seconds: seconds);
    widget.advancedPlayer.seek(newDuration);
  }

  Widget btnFast() {
    return IconButton(
      onPressed: () async {
        await widget.advancedPlayer.setPlaybackRate(1.5);
      },
      icon: const ImageIcon(
        AssetImage('img/forward.png'),
        size: 15,
        color: Colors.black,
      ),
    );
  }

  Widget btnSlow() {
    return IconButton(
      onPressed: () async {
        await widget.advancedPlayer.setPlaybackRate(0.5);
      },
      icon: const ImageIcon(
        AssetImage('img/backword.png'),
        size: 15,
        color: Colors.black,
      ),
    );
  }

  Widget btnRepeat() {
    return IconButton(
      onPressed: () async {
        if (isRepeat == false) {
          await widget.advancedPlayer.setReleaseMode(ReleaseMode.loop);
          setState(() {
            isRepeat = true;
            color = Colors.blue;
          });
        } else {
          await widget.advancedPlayer.setReleaseMode(ReleaseMode.release);
          setState(() {
            isRepeat = false;
            color = Colors.black;
          });
        }
      },
      icon: ImageIcon(
        const AssetImage('img/repeat.png'),
        size: 15,
        color: color,
      ),
    );
  }

  Widget btnLoop() {
    return IconButton(
      onPressed: () async {
        books = context.watch<BooksProvider>().books;

        widget.advancedPlayer.stop();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => DetailsPage(
              book: books.elementAt(Random().nextInt(books.length)),
              startPlay: true,
            ),
          ),
        );
      },
      icon: const ImageIcon(
        AssetImage('img/loop.png'),
        size: 15,
        color: Colors.black,
      ),
    );
  }

  Widget loadAsset() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnFast(),
          // btnLoop(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BooksProvider>(
      builder: (context, booksProvider, _) {
        books = booksProvider.books;
        return Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _position.toString().split('.').first,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      _duration.toString().split('.').first,
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
              slider(),
              loadAsset(),
            ],
          ),
        );
      },
    );
  }
}
