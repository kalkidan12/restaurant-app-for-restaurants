import 'package:flutter/material.dart';

class MenuList extends StatefulWidget {
  const MenuList({super.key});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fast Track | Restaurant",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(
            8 * screenWidth / 100, 20, 7 * screenWidth / 100, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Menu",
                  style: TextStyle(
                      fontSize: 28.0,
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w300,
                      fontFamily: "Merriweather"),
                ),
                Icon(
                  Icons.add,
                  color: const Color(0xFF736c6c),
                  size: 42.0,
                ),
              ],
            ),
            const Divider(
              color: Colors.black87,
            ),
            const SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height - 200,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  MenuListItem(),
                  MenuListItem(),
                  MenuListItem(),
                  MenuListItem(),
                  MenuListItem(),
                  MenuListItem(),
                ],
              ),
            ),
            // MenuListItem(),
            // MenuListItem(),
          ],
        ),
      ),
    );
  }
}

class MenuListItem extends StatefulWidget {
  const MenuListItem({super.key});

  @override
  State<MenuListItem> createState() => _MenuListItemState();
}

class _MenuListItemState extends State<MenuListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 241, 241, 241),
        boxShadow: List.filled(
          3,
          const BoxShadow(
            blurRadius: 4,
            blurStyle: BlurStyle.outer,
            color: Colors.black12,
          ),
        ),
        // border: Border.all(
        //   color: Colors.black,
        // ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              // borderRadius: const BorderRadius.only(
              //   topLeft: Radius.circular(20),
              //   bottomLeft: Radius.circular(20),
              // ),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              child: Image.network(
                'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YnVyZ2VyfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                fit: BoxFit.fill,
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
          Container(
            height: 120,
            // width: MediaQuery.of(context).size.width - 174,
            padding: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 243, 243, 243),
              // border: Border.all(
              //   color: Colors.black,
              // ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        "Menu Name",
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w300,
                            fontFamily: "Merriweather"),
                      ),
                      // SizedBox(height: 10,),
                      SizedBox(
                        width: 130,
                        child: Text(
                          "This is a description description description description description.",
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w300,
                              fontFamily: "Merriweather"),
                        ),
                      ),
                      Text(
                        "\$10.95",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w300,
                            fontFamily: "Merriweather"),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.edit_square,
                    color: Colors.blue[400],
                    size: 30,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
