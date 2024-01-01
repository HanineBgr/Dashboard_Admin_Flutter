import 'package:admin/constants.dart';
import 'package:admin/screens/News/news_list.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:admin/models/News.dart';
import 'package:admin/services/news_servvice.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SideMenu(),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Text(
                      "News",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Call the scrapeAndSaveNews method
                        NewsService.scrapeAndSaveNews();
                      },
                      child: Text('Scrape News'),
                      //give color to the button
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: defaultPadding),
                    FutureBuilder<List<News>>(
                      future: NewsService.getAllNews(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return NewsList(newslist: snapshot.data!);
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        }
                        // By default, show a loading indicator
                        return CircularProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
