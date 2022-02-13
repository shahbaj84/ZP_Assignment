import 'package:flutter/material.dart';
import 'package:zp_assignment/common/app_methods.dart';
import 'package:zp_assignment/models/country.dart';

class CountryDetails extends StatefulWidget {
  final Country? country;
  const CountryDetails({Key? key, this.country}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CountryDetails();
  }
}

class _CountryDetails extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.country?.emoji}  ${(widget.country?.name ?? "")}"),centerTitle: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
         Row(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.country?.emoji ?? "", style: const TextStyle(fontSize: 40)),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getNameAndContinent(widget.country!),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(height: 5,),
                      Text("Currency - ${widget.country?.currency ?? ""}",style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),),
                      const SizedBox(height: 5,),
                      Text("Phone Code - ${widget.country?.phone ?? ""}",style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    ]),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text("Languages - ",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (widget.country?.languages ?? []).map<Widget>((e) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                child: Row(
                  children: [
                    Text(e.name ?? "",style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text(" (${e.nativeValue ?? ""})"),
                  ],
                ),
              )).toList(),)
          ],)
        ]),
      ),
    );
  }
}
