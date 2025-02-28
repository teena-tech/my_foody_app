import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_swissy/core/api_service.dart';
import 'package:online_swissy/data/models/property_model.dart';
import 'package:online_swissy/data/repository/home_repository.dart';
import 'package:online_swissy/logic/bloc/home_bloc.dart';
import 'package:online_swissy/ui/widgets/property_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: BlocProvider(
        create: (context) =>
            HomeBloc(HomeRepository(ApiService()))..add(FetchHomeData()),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return _buildHomeContent(state);
            } else if (state is HomeError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text("Welcome!"));
          },
        ),
      ),
      floatingActionButton: _buildFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: "Hei ",
                style: TextStyle(fontSize: 12, color: Colors.black)),
            TextSpan(
                text: "Anna!",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
          ],
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
        ),
        SizedBox(width: 16),
      ],
    );
  }

  Widget _buildHomeContent(HomeLoaded state) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchAndFilter(),
          SizedBox(height: 20),
          _buildCategoryFilters(),
          SizedBox(height: 20),
          _buildSectionHeader("Top Nearby Destinations"),
          _buildPropertyList(state.properties.cast<PropertyModel>()),
          SizedBox(height: 20),
          _buildSectionHeader("Featured Property"),
          _buildPropertyList(state.properties.cast<PropertyModel>()),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.orange),
              hintText: "Search...",
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.filter_list, color: Colors.white),
          label: Text("Filters"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade900,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryButton(String title) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(title),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Text("See more", style: TextStyle(color: Colors.blue.shade900)),
              Icon(Icons.arrow_forward_ios,
                  size: 14, color: Colors.blue.shade900),
            ],
          ),
        ),
      ],
    );
  }

  // Widget _buildPropertyList(List<PropertyModel> properties) {
  //   return GridView.builder(
  //     shrinkWrap: true,
  //     physics: NeverScrollableScrollPhysics(),
  //     itemCount: properties.length,
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2,
  //       crossAxisSpacing: 10,
  //       mainAxisSpacing: 10,
  //       childAspectRatio: 0.8,
  //     ),
  //     itemBuilder: (context, index) {
  //       return PropertyCard(property: properties[index]);
  //     },
  //   );
  // }
  Widget _buildCategoryFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, //
      child: Row(
        children: [
          _buildCategoryButton("Real Estate Investment"),
          SizedBox(width: 10),
          _buildCategoryButton("Luxury Apartments"),
          SizedBox(width: 10),
          _buildCategoryButton("Residential Properties"),
          SizedBox(width: 10),
          _buildCategoryButton("Agriculture Land"),
          SizedBox(width: 10),
          _buildCategoryButton("Commercial Spaces"),
        ],
      ),
    );
  }

  Widget _buildPropertyList(List<PropertyModel> properties) {
    return SizedBox(
      height: (properties.length / 2).ceil() * 250,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: properties.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return PropertyCard(property: properties[index]);
        },
      ),
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.blue.shade900,
      child: Icon(Icons.add, size: 30, color: Colors.white),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.home, color: Colors.blue.shade900),
                onPressed: () {}),
            IconButton(
                icon: Icon(Icons.notifications, color: Colors.grey),
                onPressed: () {}),
            SizedBox(width: 40),
            IconButton(
                icon: Icon(Icons.chat_bubble_outline, color: Colors.grey),
                onPressed: () {}),
            IconButton(
                icon: Icon(Icons.grid_view, color: Colors.grey),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
