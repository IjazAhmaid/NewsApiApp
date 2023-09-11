import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/catagories_news_models.dart';
import 'package:newsapp/view_models/news_view_models.dart';

class CatagoriesScreen extends StatefulWidget {
  const CatagoriesScreen({super.key});

  @override
  State<CatagoriesScreen> createState() => _CatagoriesScreenState();
}

class _CatagoriesScreenState extends State<CatagoriesScreen> {
  NewsViewsModels newsviewmodels = NewsViewsModels();
  final formate = DateFormat('MMMM dd,yyyy');

  String catagoryname = 'General';
  List<String> catagorieslist = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: catagorieslist.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      catagoryname = catagorieslist[index];
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: catagoryname == catagorieslist[index]
                                ? Colors.blue
                                : Colors.grey),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            catagorieslist[index].toString(),
                            style: GoogleFonts.poppins(
                                fontSize: 13, color: Colors.white),
                          ),
                        )),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
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
                      //  scrollDirection: Axis.vertical,
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
          ],
        ),
      ),
    );
  }
}

const spinkit = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
