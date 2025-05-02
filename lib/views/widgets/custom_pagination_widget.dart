import 'package:flutter/material.dart';

class CustomPaginationWidget extends StatelessWidget {
  int totalPages;
  int currentPage;
  Function(int page) onPageChange;
  CustomPaginationWidget(
      {this.totalPages = 0,
      this.currentPage = 0,
      required this.onPageChange,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (currentPage > 1) {
                  onPageChange(currentPage - 1);
                }
              }),
          IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                if (currentPage < totalPages) {
                  onPageChange(currentPage + 1);
                }
              }),
        ]));
  }
}
