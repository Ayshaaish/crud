import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'apiconst.dart';
import 'customermodel.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

List customer = [];
List<Customer> customerList = [];
List<Customer> customerList2 = [];
TextEditingController searchController = TextEditingController();

class _CustomerListState extends State<CustomerList> {
  getCustomerList() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            '${CustomerConstants.customerUrl}/${CustomerConstants.customerList}'));
    http.StreamedResponse response = await request.send();
    customer.clear();
    Map abc = jsonDecode(await response.stream.bytesToString());
    customer = abc["getCustomerList"];
    for (var data in customer) {
      customerList.add(Customer.fromJson(data));
    }
    print(customerList.length);

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    if (mounted) {
      setState(() {});
    }
  }

  searchNames(String searchValue) {
    customer.clear();

    if (searchValue == '') {
      setState(() {});
      return;
    }

    customerList2.forEach(
          (element) {
        if (element.customername.contains(searchValue.toLowerCase()) &&
            searchValue.isNotEmpty) {
          // print(searchValue);
          customer.add(element);
        }
        // print(customer.length);
      },
    );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getCustomerList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CustomerList"),
      ),
      body: Padding(
        padding:  EdgeInsets.all(width*0.04),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              onChanged: (value) {
                searchNames(searchController.text);

                if(searchController.text.isEmpty){
                  customer.addAll(customerList2);
                }
                setState(() {

                });
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search,color: Colors.grey,size: width*0.07),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width*0.04),
                      borderSide: BorderSide(
                          color: Colors.deepPurple
                      )
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width*0.04),
                      borderSide: BorderSide(
                          color: Colors.deepPurple
                      )
                  )
              ),
            ),
            SizedBox(height: height*0.03,),
            Expanded(
              child: ListView.builder(
                itemCount:customer.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Customer details=customer[index];
                  return Container(
                    height: height*0.3,
                    width: width*0.7,
                    margin: EdgeInsets.only(bottom: width*0.03),
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(width*0.05)
                    ),
                    child: Column(
                      children: [
                        Text('${index+1}'),
                        Text(details.customername)
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
