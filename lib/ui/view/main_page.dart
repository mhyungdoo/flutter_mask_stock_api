
import 'package:flutter/material.dart';
import 'package:flutter_mask_stock_api/ui/widget/remain_stat_list_tile.dart';
import 'package:flutter_mask_stock_api/viewmodel/store_model.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : ${storeModel.stores.length} 곳'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              storeModel.fetch();

            },
          )
        ],
      ),
      body: storeModel.isLoading == true
          ? loadingWidget()
          : ListView(
        // 로딩 중이면 로딩 화면을 보여주고 로딩이 false면 리스트뷰를 보여준다
        children: storeModel.stores.map((e) {
          return ListTile(
            title: Text(e.name),
            subtitle: Text(e.addr),
            trailing: RemainStatListTile(e),
          );
        }).toList(),
      ),
    );
  }



  Widget loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('정보를 가져오는 중'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
