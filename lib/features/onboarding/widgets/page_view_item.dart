import 'package:factopro/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PageViewItem extends StatefulWidget {
  const PageViewItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.content,
  });

  final String imageUrl;
  final String title;
  final String content;

  @override
  State<PageViewItem> createState() => _PageViewItemState();
}

class _PageViewItemState extends State<PageViewItem> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 300,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: context.colorScheme.outline),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(widget.imageUrl, width: 100),
                  Text(
                    'صدور فاکتور در لحظه',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'کمتر از ۳ ثانیه با بارکد',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.tertiary,
                    ),
                  ),
                  Gap(10),
                  Container(
                    width: 200,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.colorScheme.outline,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '۱۰۰٪ آفلاین',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Gap(12),
                        Text('چاپ سریع فیش'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(20),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Gap(12),
            Text(
              widget.content,
              style: TextStyle(fontSize: 16),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
