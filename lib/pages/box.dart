import 'package:flutter/material.dart';

class BoxPage extends StatelessWidget {
  const BoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text("Community", style: TextStyle(color: Colors.black)),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.camera_alt_outlined, color: Colors.black),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _topView()),
            _infoList(),
          ],
        ),
      ),
    );
  }

  //topview
  Widget _topView() {
    return Container(
      padding: EdgeInsets.all(16),
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 10),
        ),
      ),
      child: ListView.builder(
        scrollDirection: .horizontal,
        itemCount: 10,
        itemBuilder: (cxt, i) {
          if (i == 0) {
            return Container(
              margin: EdgeInsets.all(4),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: .circle,
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: Icon(Icons.camera_alt_outlined),
                  ),
                  SizedBox(height: 8),
                  Text("Add story"),
                ],
              ),
            );
          }
          return Container(
            decoration: BoxDecoration(color: Colors.white),
            margin: EdgeInsets.all(4),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: .circle,
                    border: Border.all(width: 1, color: Colors.blue),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "pink",
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  //listview
  Widget _infoList() {
    return SliverList.builder(
      itemCount: 20,
      itemBuilder: (cxt, i) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              //userINfo
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      "https://picsum.photos/id/237/200/300",
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        "sara Jekins",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "chanix, France",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
              //Image
              SizedBox(height: 16),
              //image
              Image.network(
                "https://picsum.photos/seed/picsum/200/300",
                width: .infinity,
                height: 380,
                fit: .cover,
              ),
              //tool button
              Row(
                mainAxisAlignment: .start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite, color: Colors.grey),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.collections, color: Colors.grey),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.chat_bubble_outline, color: Colors.grey),
                  ),
                  Spacer(),
                  Text("12h ago",style: TextStyle(color: Colors.grey),)
                ],
              ),
              //coment
              Text(
                "A calm sunset over the ocean, with golden orange and pink clouds stretching across the sky. Gentle waves roll onto a quiet sandy beach, and a single sailboat drifts slowly near the horizon",
              ),
            ],
          ),
        );
      },
    );
  }
}
