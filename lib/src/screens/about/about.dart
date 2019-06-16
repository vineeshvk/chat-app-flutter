import 'package:chat_app/src/constants/colors.dart';
import 'package:chat_app/src/constants/gradients.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context),
      body: body(context),
    );
  }

  Widget appBarComponent(context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Container(
          child: Row(
        children: <Widget>[
          Container(
            width: 90,
            height: 80,
            padding: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              gradient: BLUE_GRADIENT,
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(100)),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: WHITE_COLOR,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      )),
    );
  }

  Widget body(context) {
    return Container(
      padding: EdgeInsets.all(25),
      child: ListView(
        children: <Widget>[
          headerComponent(),
          Container(margin: EdgeInsets.only(top: 40)),
          descriptionComponent(),
          Container(margin: EdgeInsets.only(top: 40)),
          codeSourceComponent(),
          Container(margin: EdgeInsets.only(top: 20)),
          Divider(),
          Container(margin: EdgeInsets.only(top: 40)),
          developerItemComponent(
            "Front-end and Back-end developer",
            "Vineesh V",
            github: "https://github.com/vineeshvk",
            linkedIn: "https://www.linkedin.com/in/vineeshvk/",
          ),
          Container(margin: EdgeInsets.only(top: 30)),
          developerItemComponent(
            "Designer",
            "Roshan G Rahman",
            github: "https://github.com/roshanrahman/",
            linkedIn: "https://www.linkedin.com/in/roshanrahman6399/",
          )
        ],
      ),
    );
  }

  Widget headerComponent() {
    return Text("About app", style: TextStyle(fontSize: 36));
  }

  Widget descriptionComponent() {
    return Text(
      "It’s a fully functioning chat application built using flutter and uses graphql to interact with the database",
      style: TextStyle(
        fontSize: 19,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget codeSourceComponent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Code for the app',
          style: TextStyle(fontSize: 18),
        ),
        OutlineButton.icon(
          icon: Icon(Icons.link),
          label: Text("Github"),
          onPressed: () {
            launchURL("github.com/vineeshvk/chat-app-flutter");
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
      ],
    );
  }

  Widget developerItemComponent(
    String role,
    String name, {
    String linkedIn,
    String github,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          role,
          style: TextStyle(fontSize: 18),
        ),
        Container(margin: EdgeInsets.only(top: 5)),
        Row(
          children: <Widget>[
            Text(
              name,
              style: TextStyle(fontSize: 24, color: PALE_ORANGE),
            ),
            Expanded(child: Container()),
            IconButton(
              icon: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  "assets/icon/linkedin_ic.png",
                  width: 26,
                  height: 26,
                ),
              ),
              onPressed: () => launchURL(linkedIn),
            ),
            Container(margin: EdgeInsets.only(left: 5)),
            IconButton(
              icon: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  "assets/icon/github_ic.png",
                  width: 26,
                  height: 26,
                ),
              ),
              onPressed: () async {
                await launchURL(github);
              },
            )
          ],
        )
      ],
    );
  }

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
