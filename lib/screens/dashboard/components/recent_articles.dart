import 'package:admin/models/RecentArticle.dart';
import 'package:admin/models/RecentFile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../models/RecentCategory.dart';
import '../../../responsive.dart';

class RecentArticles extends StatelessWidget {
  const RecentArticles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Articles",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 30,width: 30),
          ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text("Add New"),
            ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Nom"),
                ),
                DataColumn(
                  label: Text("Adreese"),
                ),
                DataColumn(
                  label: Text("Adresse mail"),
                ),
              ],
              rows: List.generate(
                demoRecentArticles.length,
                (index) => recentFileDataRow(demoRecentArticles[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentArticle fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.Adresse!,
              height: 30,
              width: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(fileInfo.Nom!),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.Adresse!)),
      DataCell(Text(fileInfo.Adresse_mail!)),
    ],
  );
}
