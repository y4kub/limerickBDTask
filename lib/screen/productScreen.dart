import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/product/product_bloc.dart';
import '../blocs/product/product_event.dart';
import '../blocs/product/product_state.dart';
import 'loginScreen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  TextEditingController edtSearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
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
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductListLoaded) {
            return Column(
              children: [
                PreferredSize(
                  preferredSize: Size.fromHeight(56.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: edtSearchController,
                      onChanged: (query) {
                        context.read<ProductListBloc>().add(SearchProducts(query));
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
                ListView.builder(
                  itemCount: state.productList.length,
                  itemBuilder: (context, index) {
                    final product = state.productList[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text(product.price),
                    );
                  },
                ),
              ],
            );
          } else if (state is ProductListError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('No products available.'));
          }
        },
      ),
    );
  }
}
