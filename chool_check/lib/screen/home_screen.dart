import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static final LatLng companyLatLng = LatLng(
    37.549186395087,
    127.07505567644,
  );

  static final Marker marker = Marker(
    markerId: MarkerId('school'),
    position: companyLatLng,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: renderAppBar(),
        body: FutureBuilder<String>(
          future: checkPermission(),
          builder: (context, snapshot) {
            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == '위치 권한이 허가 되었습니다.') {
              return Column(children: [
                Expanded(
                  flex: 2,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: companyLatLng,
                      zoom: 16,
                    ),
                    markers: Set.from([marker]),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.timelapse_outlined,
                            color: Colors.blue, size: 50.0),
                        const SizedBox(height: 20.0),
                        ElevatedButton(onPressed: () {}, child: Text("check")),
                      ],
                    ))
              ]);
            }
            return Center(
                child: Text(
              snapshot.data.toString(),
            ));
          },
        ));
  }
}

AppBar renderAppBar() {
  return AppBar(
    centerTitle: true,
    title: Text(
      'cooool check',
      style: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.w700,
      ),
    ),
    backgroundColor: Colors.white,
  );
}

Future<String> checkPermission() async {
  final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isLocationEnabled) {
    return '위치 서비스를 활성화 해주세요.';
  }
  LocationPermission checkedPermission = await Geolocator.checkPermission();
  if (checkedPermission == LocationPermission.denied) {
    checkedPermission = await Geolocator.requestPermission();
  }
  if (checkedPermission == LocationPermission.denied) {
    return '위치 권한을 허가해주세요';
  }
  if (checkedPermission == LocationPermission.deniedForever) {
    return '앱의 위치 권한을 허가해주세요';
  }
  return '위치 권한이 허가 되었습니다.';
}
