import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shopify/repository/products.dart';

class SearchQuery extends StatefulWidget {
  const SearchQuery({super.key});

  @override
  State<SearchQuery> createState() => _SearchQueryState();
}

class _SearchQueryState extends State<SearchQuery> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  String query = "";
  String lastQuery = "";

  List<String> suggestions = [];
  List<String> filteredSuggestions = [];

  bool showSuggestions = true;

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (value.trim().isEmpty || value == lastQuery) return;

      lastQuery = value;
      query = value;

      try {
        final data = await getSuggestions(); // Replace with actual API
        suggestions = List<String>.from(data);

        setState(() {
          filteredSuggestions =
              suggestions
                  .where(
                    (item) => item.toLowerCase().contains(query.toLowerCase()),
                  )
                  .toList();
          showSuggestions = true; // Show suggestions when user types
        });
      } catch (e) {
        debugPrint("Error fetching suggestions: $e");
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          TextField(
            controller: _controller,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade200,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.blue.shade300, width: 1.5),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Suggestions with Hide Button
          if (query.isNotEmpty && showSuggestions)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Hide Button
                TextButton(
                  onPressed: () {
                    setState(() {
                      showSuggestions = false;
                    });
                  },
                  child: const Text("Hide Suggestions"),
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:
                      filteredSuggestions.isNotEmpty
                          ? ListView.builder(
                            itemCount: filteredSuggestions.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(filteredSuggestions[index]),
                                onTap: () {
                                  _controller.text = filteredSuggestions[index];
                                  setState(() {
                                    query = filteredSuggestions[index];
                                    filteredSuggestions.clear();
                                    showSuggestions = false;
                                  });
                                },
                              );
                            },
                          )
                          : const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text("No results found"),
                            ),
                          ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
