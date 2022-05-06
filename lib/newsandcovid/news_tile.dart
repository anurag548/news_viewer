import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  String title, description, content, url, imageUrl;
  NewsTile(
      {required this.title,
      required this.description,
      required this.content,
      required this.url,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        //color: Colors.amber,
        margin: const EdgeInsets.only(bottom: 24),
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: Container(
            //color: Colors.pink,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(16),
                    bottomLeft: Radius.circular(6))),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      imageUrl,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(title,
                      maxLines: 2,
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 325,
                      ),
                      IconButton(
                          onPressed: () => {print('Added to favs')},
                          icon: const Icon(Icons.star_border))
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
