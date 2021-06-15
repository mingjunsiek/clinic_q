import 'package:clinic_q/views/google_map.dart';
import 'package:flutter/material.dart';
import 'package:clinic_q/utils/constants.dart';
import 'package:clinic_q/widgets/FormTextField.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double _initFabHeight = 125.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 100.0;
  MapScreen mapScreen = MapScreen();

  @override
  void initState() {
    _fabHeight = _initFabHeight;
    super.initState();
  }

  Widget _scrollingList(ScrollController sc) {
    final items = List<String>.generate(10, (i) => "Item $i");

    return Column(
      children: [
        SizedBox(
          height: 30.0,
        ),
        Container(
          height: 5.0,
          width: 30.0,
          color: kPrimaryBtnColor,
        ),
        Expanded(
          child: ListView.builder(
              controller: sc,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  onTap: () {},
                  title: Text(
                    '${items[index]}',
                    style: TextStyle(color: Colors.black),
                  ),
                ));
              }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height - 300;

    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: 0.5,
            panelBuilder: (ScrollController sc) => _scrollingList(sc),
            body: Center(
              child: MapScreen(),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            onPanelSlide: (double pos) => setState(() {
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                  _initFabHeight;
            }),
          ),
          Positioned(
            right: 20.0,
            bottom: _fabHeight,
            child: FloatingActionButton(
              child: Icon(
                Icons.gps_fixed,
                color: kPrimaryBtnColor,
              ),
              onPressed: () {},
              backgroundColor: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 70.0,
              left: 8.0,
              right: 8.0,
            ),
            child: FormTextField(
              labelText: "SEARCH CLINICS",
              fieldKeyboardType: TextInputType.visiblePassword,
            ),
          )
        ],
      ),
    );
  }
}
