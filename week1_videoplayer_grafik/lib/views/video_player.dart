import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:week1_videoplayer_grafik/model/api.dart';
import 'package:week1_videoplayer_grafik/model/favorite_model.dart';

class VideoPlayer extends StatefulWidget {
  final String title;
  final String url;
  final String email;

  VideoPlayer({this.title, this.url, this.email});
  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  Future<List> getPlaylist() async {
    final response = await http.get(widget.url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List>(
        future: getPlaylist(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? Playlist(snapshot.data, widget.email)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class Playlist extends StatefulWidget {
  final List listYt;
  final String email;

  Playlist(this.listYt, this.email);

  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  FavoriteModel favoriteModel;
  var loading = false;
  Future<FavoriteModel> _getFavorite() async {
    setState(() {
      loading = true;
    });
    final response = await http.get(BaseUrl.dataFavorite + widget.email);
    favoriteModel = FavoriteModel.fromJson(jsonDecode(response.body));
    setState(() {
      loading = false;
    });
    return favoriteModel;
  }

  bool _favoriteContent = false;

  _statusFav() {
    setState(() {
      _favoriteContent = !_favoriteContent;
    });
  }

  _favorite(String data) {
    if (data.contains(favoriteModel.idFavorite[0])) {
      return Icon(Icons.bookmark_rounded);
    } else {
      return Icon(Icons.bookmark_outline_rounded);
    }
  }

  @override
  void initState() {
    _getFavorite();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: widget.listYt == null ? 0 : widget.listYt.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowVideo(
                                  "https://youtube.com/embed/${widget.listYt[index]['contentDetails']['videoId']}")),
                        );
                      },
                      child: Container(
                        height: 230,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(widget.listYt[index]
                                    ['snippet']['thumbnails']['high']['url']))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: size.width * 0.05),
                            child: Container(
                              width: size.width * 0.7,
                              child: Text(
                                widget.listYt[index]['snippet']['title'],
                              ),
                            ),
                          ),
                          IconButton(
                            // icon: Icon(
                            //   _favoriteContent
                            //       ? Icons.bookmark_outlined
                            //       : Icons.bookmark_outline_rounded,
                            // ),

                            icon: _favorite(widget.listYt[index]['id']),
                            // icon: _favorite(
                            //     'UExrNTd6SExLbG5UOEVZN0U1RF9qLTdIY2lUZGJuRjN0Ui4xMkVGQjNCMUM1N0RFNEUx'),
                            onPressed: () {
                              _statusFav();
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              );
            },
          );
  }
}

class ShowVideo extends StatelessWidget {
  final url;
  ShowVideo(this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
