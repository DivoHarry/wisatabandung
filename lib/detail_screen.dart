//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:wisatabandung/model/tourism_place.dart';

var informationTextStyle = const TextStyle(fontFamily: 'Oxygen');

class DetailScreen extends StatelessWidget {
  final TourismPlace place;
  const DetailScreen({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 800) {
        return DetailWebPage(place: place);
      } else {
        return DetailMobilePage(place: place);
      }
    });
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.red,
        ),
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        });
  }
}

class DetailWebPage extends StatefulWidget {
  final TourismPlace place;

  const DetailWebPage({Key? key, required this.place}) : super(key: key);

  @override
  State<DetailWebPage> createState() => _DetailWebPageState();
}

class _DetailWebPageState extends State<DetailWebPage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    //void dispose() {
    // _scrollController.dispose();
    //super.dispose();
    //}

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 64),
        child: Center(
          child: SizedBox(
            width: 1200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Wisata Bandung',
                  style: TextStyle(fontSize: 32, fontFamily: 'Staatliches'),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(widget.place.imageAsset),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Scrollbar(
                            controller: _scrollController,
                            child: Container(
                              height: 150,
                              padding: const EdgeInsets.only(bottom: 16),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: widget.place.imageUrls.map((url) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(url),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                    Expanded(
                        child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              widget.place.nama,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontFamily: 'Staatliches', fontSize: 30),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_today),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(widget.place.openDays)
                                  ],
                                ),
                                const FavoriteButton()
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.access_time),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(widget.place.openTime)
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Icon(Icons.monetization_on),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(widget.place.ticketPrice)
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  widget.place.description,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                      fontSize: 16, fontFamily: 'Oxygen'),
                                ))
                          ],
                        ),
                      ),
                    )),
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

class DetailMobilePage extends StatelessWidget {
  final TourismPlace place;
  const DetailMobilePage({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Hero(
          tag: "tampil",
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Stack(children: [
                  Image.asset(place.imageAsset),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.arrow_back)),
                          ),
                          const FavoriteButton(),
                        ],
                      ),
                    ),
                  )
                ]),
                Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: Text(
                      place.nama,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Staatliches'),
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(place.openDays, style: informationTextStyle)
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(Icons.access_time),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(place.openTime, style: informationTextStyle)
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(Icons.monetization_on),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(place.ticketPrice, style: informationTextStyle)
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  //padding: ,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    place.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: place.imageUrls.map((url) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(9),
                          child: Image.network(url),
                        ),
                      );
                    }).toList(),
                  ),
                )
                //Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
