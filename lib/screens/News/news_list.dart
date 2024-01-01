import 'package:admin/screens/News/news_detail.dart';
import 'package:flutter/material.dart';
import 'package:admin/models/News.dart';
import 'package:admin/services/news_servvice.dart';
import '../../../constants.dart';

class NewsList extends StatefulWidget {
  final List<News> newslist;

  const NewsList({
    Key? key,
    required this.newslist,
  }) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      constraints: BoxConstraints(
        maxHeight: 500, // Adjust the maximum height as needed
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Scraped News",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: widget.newslist.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.newslist[index].title!),
                  subtitle: Text(widget.newslist[index].url!),
                  trailing: PopupMenuButton<String>(
                    itemBuilder: (context) => [
                      PopupMenuItem<String>(
                        value: 'Details',
                        child: ListTile(
                          leading: Icon(Icons.edit),
                          iconColor: Colors.blue,
                          title: Text('Details'),
                          textColor: Colors.blue,
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: ListTile(
                          leading: Icon(Icons.delete),
                          iconColor: Colors.red,
                          title: Text('Delete'),
                          textColor: Colors.red,
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'Details') {
                        _navigateToDetailsScreen(widget.newslist[index]);
                      } else if (value == 'delete') {
                        // Call the deleteNews method
                        NewsService.deleteNews(widget.newslist[index].id!);
                        setState(() {
                          widget.newslist.removeAt(index);
                        });
                        print('Delete News: ${widget.newslist[index].id}');
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Function to navigate to NewsDetailScreen
  void _navigateToDetailsScreen(News news) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailScreen(
          title: news.title!,
          newsPhoto: news.newsPhoto!,
          description: news.description!,
          source: news.source!,
        ),
      ),
    );
  }
}
