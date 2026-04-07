import 'package:flutter/material.dart';

class MinePage extends StatelessWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gear shop", style: TextStyle(color: Colors.black)),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart, color: Colors.black),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _topCard()),
            _listView(),
          ],
        ),
      ),
    );
  }

  // top card
  Widget _topCard() {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [Color(0xff2563EB), Color(0xff4F46E5)],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("WINTER SALE", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 6),
                  Text(
                    "Up to 30% Off\nSelected Gear",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Shop now"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: Icon(
                Icons.circle_notifications_sharp,
                color: Colors.white60,
                size: 44,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //List
  Widget _listView() {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 168 / 268,
        ),
        itemCount: 20,
        itemBuilder: (cxt, index) {
          return Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  blurRadius: 10,
                  offset: Offset(2, 4),
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1, // 1:1 宽高比
                  child: Image.network(
                    "https://picsum.photos/200/300?grayscale",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Text("BUTION", style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13
                )),
                Text("Custom Snowboard 2025", style: TextStyle(
                  fontSize: 15
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Row(
                  children: [
                    Text("\$568", style: TextStyle(
                      fontSize: 15
                    )),
                    Spacer(),
                    // 把 IconButton 换成这个 → 永远不溢出
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: cxt,
                          builder: (cnt) {
                            return AlertDialog(
                              title: Text("title"),
                              content: Text("add success"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(cnt),
                                  child: Text("ok"),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(cnt),
                                  child: Text("cancle"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.add_circle,
                        size: 22,  // 你想多大就多大
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
