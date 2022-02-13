import 'package:flutter/material.dart';
import 'package:zp_assignment/common/app_methods.dart';
import 'package:zp_assignment/models/country.dart';
import 'package:zp_assignment/ui/country_details.dart';

class CountryItem extends StatefulWidget {
  final Country country;
  const CountryItem({Key? key, required this.country}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CountryItem();
  }
}

class _CountryItem extends State<CountryItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CountryDetails(country: widget.country,)));
      },
      child: Card(
        child: Column(children: [
          Row(
            children: [
              Text(widget.country.emoji!, style: const TextStyle(fontSize: 40)),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getNameAndContinent(widget.country),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(widget.country.currency ?? "")
                    ]),
              )
            ],
          )
        ]),
      ),
    );
  }
}
