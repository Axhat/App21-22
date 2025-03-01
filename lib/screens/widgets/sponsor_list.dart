// @dart=2.9

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:techapp/models/Sponsor.dart';
import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Sponsor> sponsors = FetchDataProvider.sponsors;
    if (sponsors.length > 0) {
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
          child:
              LoadingAnimationWidget.staggeredDotsWave(color: white, size: 150),
        ),
      );
    }
  }
}

class CardItem extends StatelessWidget {
  final Sponsor item;

  const CardItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: () => launch('${item.link}'),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              // Divider(
              //   color: grey,
              //   thickness: 2,
              // ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  '${item.imageurl}',
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
              ),
              // Divider(
              //   color: grey,
              //   thickness: 2,
              //   height: 5,
              // ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: AutoSizeText(
                  '${item.name}',
                  style: h2s,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
