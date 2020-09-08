
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mask_stock_api/model/store.dart';

class RemainStatListTile extends StatelessWidget {

  final Store store;
  RemainStatListTile(this.store);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(store.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(store.addr),
          Text('${store.km}km'),
        ],
      ),
      trailing: _buildRemainStatWidget(store),
      onTap: (){
        _launchURL(store.lat, store.lng);
      },
    );
  }

  Widget _buildRemainStatWidget(Store store) {
    // 단위 기능을 메소드로 만들어 위젯으로 활용하는 방식
    var remainStat = '판매중지';
    var description = '판매중지';
    var color = Colors.black;

    if (store.remainStat == 'plenty') {
      remainStat = '충분';
      description = '100개 이상';
      color = Colors.green;
    }

    switch (store.remainStat) {
      case 'plenty':
        remainStat = '충분';
        description = '100개 이상';
        color = Colors.green;
        break;

      case 'some':
        remainStat = '보통';
        description = '30 ~ 100개';
        color = Colors.yellow;
        break;

      case 'few':
        remainStat = '부족';
        description = '2~30개 이상';
        color = Colors.red;
        break;

      case 'empty':
        remainStat = '소진임박';
        description = '1개 이하';
        color = Colors.grey;
        break;
      default:
    }

    return Column(
      children: <Widget>[
        Text(
          remainStat,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        Text(description,
            style: TextStyle(color: color, fontWeight: FontWeight.bold))
      ],
    );
  }


  _launchURL(double lat, double lng) async {
    var url = 'https://google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}


