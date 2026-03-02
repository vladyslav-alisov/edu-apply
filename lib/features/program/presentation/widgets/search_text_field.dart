import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField(
      {super.key,
      required TextEditingController searchController,
      required VoidCallback onClosePress,
      required VoidCallback onEditingComplete})
      : _searchController = searchController,
        _onClosePress = onClosePress,
        _onEditingComplete = onEditingComplete;

  final TextEditingController _searchController;
  final VoidCallback _onClosePress;
  final VoidCallback _onEditingComplete;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  void _onClosePress() {
    setState(() => widget._searchController.clear());
    widget._onClosePress();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: TextFormField(
        onChanged: (value) => setState(() {}),
        controller: widget._searchController,
        decoration: InputDecoration(
          hintText: 'Search here...',
          prefixIcon: Icon(Icons.search),
          suffixIcon: widget._searchController.text.isEmpty
              ? null
              : IconButton(
                  onPressed: _onClosePress,
                  icon: Icon(Icons.close),
                ),
        ),
        onEditingComplete: widget._onEditingComplete,
      ),
    );
  }
}
