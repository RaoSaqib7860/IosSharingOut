import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SharingOut/ApiUtils/ApiUtils.dart';
import 'package:SharingOut/provider/BlockOrderState.dart';

class OrderStatePage extends StatefulWidget {
  OrderStatePage({Key key, this.id}) : super(key: key);
  final id;
  @override
  _OrderStatePageState createState() => _OrderStatePageState();
}

class _OrderStatePageState extends State<OrderStatePage> {
  @override
  void initState() {
    final BlockOrderState _provider =
        Provider.of<BlockOrderState>(context, listen: false);
    getApiData(_provider);
    super.initState();
  }

  getApiData(BlockOrderState provider) async {
    await ApiUtilsClass.orderSateData(provider, '${widget.id}');
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<BlockOrderState>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            SizedBox(
              height: height / 10,
            ),
            Container(
              height: height,
            )
          ],
        ),
      ),
    );
  }
}
