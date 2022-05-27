import 'package:flutter/material.dart';
import '../model/service_model.dart';

class ServiceDisplay extends StatelessWidget {
  const ServiceDisplay({Key? key, required this.service}) : super(key: key);
  final Service service;

  pokeImage() => Stack(children: [
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100),
            bottomLeft: Radius.circular(100)
        ),
        color: Colors.lightGreenAccent,
      ),
      width: 100,
      height: 150,
    ),


  ]);

  pokeInfos(BuildContext context) => Container(
    margin: const EdgeInsets.only(left: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            service.isp.toUpperCase(),
            style: const TextStyle(
                color: Colors.lightBlue,
                fontSize: 35,
                fontWeight: FontWeight.w700),
          ),
          margin: const EdgeInsets.only(bottom: 5.0),
        ),
        Text('Description: ${service.description}'),
        Text('Data Capacity: ${service.data_capacity}'),
        Text('Download Speed: ${service.download_speed}'),
        Text('Upload Speed: ${service.upload_speed}'),
        Text('Price per Month: ${service.price_per_month}'),
        Text('Type of Internet: ${service.type_of_internet}'),

      ],
    ),
  );

  divider() => Container(
    color: Colors.white,
    width: 10,
    height: 100,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          children: [pokeImage(), divider(), pokeInfos(context)],
        ),
      ),
    );
  }
}
