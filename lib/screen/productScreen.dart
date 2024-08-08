import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/product/product_bloc.dart';
import '../blocs/product/product_state.dart';
import '../constants/strings.dart';
import 'loginScreen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController edtSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        floatingActionButton: Expanded(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){},
              child: Text(strOrderNow),
            ),
          ),
        ),
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(56.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: edtSearchController,
                autofocus: false,
                onChanged: (query) {
                  //  context.read<ProductListBloc>().add(SearchProducts(query));
                },
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(LoggedOut());
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductListBloc, ProductListState>(
          builder: (context, state) {
            if (state is ProductListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductListLoaded) {
              if (state.productList.isEmpty) {
                return Center(child: Text('No products found.'));
              }
              print("Length is ${state.productList.isEmpty}");
              return Column(
                children: [

                  Expanded(
                    child: ListView.builder(
                      itemCount: state.productList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final TextEditingController edtQuantity = TextEditingController();
                        final product = state.productList[index];
                        return Card(
                          child: ListTile(
                            title: Text(product.name.toString()),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ElevatedButton(onPressed: (){
                                      setState(() {
                                        edtQuantity.value=(int.parse(edtQuantity.value.toString())+1) as TextEditingValue;
                                      });
                                    }, child: Icon(Icons.add)),
                                    Container(
                                      margin: EdgeInsets.only(left: 5, right: 5),
                                      padding: EdgeInsets.all(5),
                                      height: 30,
                                      width: 30,
                                      child: TextFormField(
                                        controller: edtQuantity,
                                        textAlignVertical: TextAlignVertical.center,
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    ElevatedButton(onPressed: (){}, child: Icon(Icons.remove))
                                  ],
                                ),
                              ],
                            ),
                            trailing: Text(product.stockQty+" "+product.unitName
                                +"\n"+product.price+" BDT/unit"),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            } else if (state is ProductListError) {
              print("Error message is showing${state.message}");
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return Center(child: Text('No products available.'));
            }
          },
        ),
      ),
    );
  }
}
