// @dart=2.9

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:techapp/models/Sponsor.dart';

import 'package:techapp/retrofit/api_client.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SponsorsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final client = ApiClient.create();

    return FutureBuilder(
      future: client.getSponsors(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final errormessage = (snapshot.error as DioError).error.toString();
          print(errormessage);
          return Center(
            child: Text(
              errormessage ?? "Error",
              style: h1s,
            ),
          );
        }
        if (snapshot.hasData) {
          List<Sponsor> sponsors = snapshot.data.getFoodSponsors();
          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: sponsors.length,
            itemBuilder: (BuildContext ctx, int index) {
              return CardItem(item: sponsors[index]);
            },
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
          );
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: LoadingAnimationWidget.staggeredDotWave(
                  color: white, size: 150),
            ),
          );
        }
      },
    );
  }
}

class CardItem extends StatelessWidget {
  final Sponsor item;

  const CardItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: () => launch('${item.link}'),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white54,
            boxShadow: [
              BoxShadow(
                color: glowColor.withOpacity(0.5),
                blurRadius: 30,
                offset: Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              Divider(
                color: grey,
                thickness: 2,
              ),
              ClipRRect(
                child: Image.network(
                  '${item.imageurl}',
                  height: 90,
                ),
              ),
              Divider(
                color: grey,
                thickness: 2,
                height: 5,
              ),
              AutoSizeText(
                '${item.name}',
                style: h4,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
