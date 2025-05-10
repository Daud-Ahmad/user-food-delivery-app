import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GettingRecords extends StatelessWidget {
  const GettingRecords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
              child: Text(
            'Getting records',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
            softWrap: true,
          )),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 120,
            child: LinearProgressIndicator(
              color: const Color.fromRGBO(0xd1, 0x7b, 0x58, 1.0),
              backgroundColor: Colors.grey[200],
            ),
          )
        ],
      ),
    );
  }
}

class NoRecord extends StatelessWidget {
  final String title;
  final AsyncCallback? onRefresh;

  const NoRecord(this.title, {Key? key, this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RefreshIndicator(
        onRefresh: onRefresh ?? () async {},
        child: Stack(children: [
          ListView(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/no_record.png',
                height: 100,
                width: 170,
                fit: BoxFit.contain,
              ),

              Center(
                  child: Text(
                    title,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: Platform.isAndroid ? 20 : 22,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400),
                  )),
            ],
          ),
        ]),
      ),
    );
  }
}

class NetworkError extends StatelessWidget {
  const NetworkError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/request_error.jpg',
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
            const Center(
                child: Text(
              'Network Error',
              maxLines: 1,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            )),
          ],
        ),
      ),
    );
  }
}
