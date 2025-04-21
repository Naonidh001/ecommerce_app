import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/data/authprovider.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
              Provider.of<Authprovider>(context).user?.image ??
                  "https://liccar.com/wp-content/uploads/png-transparent-head-the-dummy-avatar-man-tie-jacket-user.png",
            ),
            radius: 58.0,
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${Provider.of<Authprovider>(context).user?.firstName ?? 'NA'}",
              ),
              SizedBox(width: 10.0),
              Text(
                "${Provider.of<Authprovider>(context).user?.lastName ?? 'NA'}",
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Text("${Provider.of<Authprovider>(context).user?.email ?? 'NA'}"),
          SizedBox(height: 20.0),
          Text("${Provider.of<Authprovider>(context).user?.gender ?? 'NA'}"),
          SizedBox(height: 40.0),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.black,
              side: BorderSide(color: Colors.black),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/login");
              Provider.of<Authprovider>(context).loggedOut();
            },
            child: Text("Sign out", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
