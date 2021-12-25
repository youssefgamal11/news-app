import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web/web_view_screen.dart';

Widget newsItem(article , BuildContext context) {
  return InkWell(
    onTap: (){Navigator.push(context, MaterialPageRoute(builder:(context) =>WebViewSceen(article['url']) ));},

    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Row(
          children: [
            Container(
              width: 130,
              height: 120,
              decoration: BoxDecoration(

                image: DecorationImage(
                    image: NetworkImage(
                        '${article['urlToImage']}'),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
Widget myDivider (){
  return Container(
    width: double.infinity,
    color: Colors.grey,
    height: 1,
  );
}
Widget articleBuilder (list  , {isSearch =false} ){
  return ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => newsItem( list[index] , context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: 10),
      fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()));
}