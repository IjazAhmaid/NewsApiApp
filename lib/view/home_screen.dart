import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/news_channels_headlines_models.dart';
import 'package:newsapp/view_models/news_view_models.dart';

import '../models/catagories_news_models.dart';
import 'catories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// ignore: constant_identifier_names
enum Filterlist { crypto, googleNews, aljazeera, Cnn, reuters, independent }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewsModels newsviewmodels = NewsViewsModels();
  final formate = DateFormat('MMMM dd,yyyy');
  Filterlist? selectedMenu;
  String name = 'crypto-coins-news';
  String catagoryname = 'General';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton<Filterlist>(
              initialValue: selectedMenu,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (Filterlist item) {
                if (Filterlist.crypto.name == item.name) {
                  name = 'crypto-coins-news';
                }
                if (Filterlist.googleNews.name == item.name) {
                  name = 'google-news';
                }
                if (Filterlist.aljazeera.name == item.name) {
                  name = 'al-jazeera-english';
                }
                if (Filterlist.Cnn.name == item.name) {
                  name = 'cnn';
                }
                if (Filterlist.reuters.name == item.name) {
                  name = 'reuters';
                }
                if (Filterlist.independent.name == item.name) {
                  name = 'ary-news';
                }
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (context) => <PopupMenuEntry<Filterlist>>[
                const PopupMenuItem<Filterlist>(
                    value: Filterlist.crypto, child: Text('Crypto')),
                const PopupMenuItem<Filterlist>(
                    value: Filterlist.googleNews, child: Text('GoogleNews')),
                const PopupMenuItem<Filterlist>(
                    value: Filterlist.aljazeera, child: Text('Aljazeera')),
                const PopupMenuItem<Filterlist>(
                    value: Filterlist.Cnn, child: Text('CNN')),
                const PopupMenuItem<Filterlist>(
                    value: Filterlist.independent, child: Text('Independent')),
                const PopupMenuItem<Filterlist>(
                    value: Filterlist.reuters, child: Text('Reuters'))
              ],
            )
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CatagoriesScreen(),
                ),
              );
            },
            icon: Image.asset('images/category_icon.png'),
          ),
          title: Center(
            child: Text(
              'News',
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: height * .55,
              width: width,
              child: FutureBuilder<NewsChannelsHeadlinesModels>(
                future: newsviewmodels.fetchNewsChanellsHeadlinesApi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: SpinKitWave(
                      size: 50,
                      color: Colors.blue,
                    ));
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data!.articles![index];
                        DateTime dateTime =
                            DateTime.parse(data.publishedAt.toString());
                        return SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * 0.6,
                                width: width * 0.9,
                                padding: EdgeInsets.symmetric(
                                    horizontal: height * .02),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: data.urlToImage.toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      child: spinkit,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error_outline,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 7,
                                child: Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    height: height * .22,
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: width * .7,
                                          child: Text(
                                            data.title.toString(),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          width: width * .7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data.source!.name.toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                formate.format(dateTime),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: FutureBuilder<CategoriesNewsModels>(
                  future: newsviewmodels.fetchCatagoriesNewsApi(catagoryname),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: SpinKitWave(
                        size: 50,
                        color: Colors.blue,
                      ));
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data!.articles![index];
                          DateTime dateTime =
                              DateTime.parse(data.publishedAt.toString());
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  height: height * .18,
                                  width: width * .3,
                                  imageUrl: data.urlToImage.toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    child: spinkit,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error_outline,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                height: height * .18,
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  children: [
                                    Text(
                                      data.title.toString(),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data.source!.name.toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          formate.format(dateTime),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                            ]),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ));
  }
}

const spinkit = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
