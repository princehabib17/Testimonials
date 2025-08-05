import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/location_service.dart';

class DestinationInput extends StatefulWidget {
  final Function(LatLng, String) onDestinationSelected;
  final bool isArabic;

  const DestinationInput({
    super.key,
    required this.onDestinationSelected,
    required this.isArabic,
  });

  @override
  State<DestinationInput> createState() => _DestinationInputState();
}

class _DestinationInputState extends State<DestinationInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  List<String> _suggestions = [];
  bool _showSuggestions = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged(String value) {
    if (value.isEmpty) {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
      });
      return;
    }

    // Mock suggestions (in real app, this would use Google Places API)
    setState(() {
      _suggestions = [
        '${value} - Riyadh',
        '${value} - Jeddah',
        '${value} - Dammam',
        '${value} Mall',
        '${value} Center',
        '${value} Street',
      ];
      _showSuggestions = true;
    });
  }

  void _onSuggestionSelected(String suggestion) async {
    _controller.text = suggestion;
    _focusNode.unfocus();
    setState(() {
      _showSuggestions = false;
    });

    // Mock coordinates (in real app, this would use Google Geocoding API)
    final coordinates = LatLng(24.7136, 46.6753); // Riyadh coordinates
    widget.onDestinationSelected(coordinates, suggestion);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Destination Input Field
        GlassmorphicCard(
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            onChanged: _onTextChanged,
            onTap: () {
              setState(() {
                _showSuggestions = _suggestions.isNotEmpty;
              });
            },
            decoration: InputDecoration(
              hintText: widget.isArabic ? 'إلى أين؟' : 'Where to?',
              hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.warmWhite.withOpacity(0.6),
              ),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.location_on,
                color: AppColors.neonCyan,
                size: 20,
              ),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _controller.clear();
                        setState(() {
                          _suggestions = [];
                          _showSuggestions = false;
                        });
                      },
                      icon: Icon(
                        Icons.clear,
                        color: AppColors.warmWhite.withOpacity(0.6),
                        size: 20,
                      ),
                    )
                  : null,
            ),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.warmWhite,
            ),
          ),
        ),

        // Suggestions
        if (_showSuggestions && _suggestions.isNotEmpty) ...[
          const SizedBox(height: AppDimensions.sm),
          GlassmorphicCard(
            child: Column(
              children: _suggestions.map((suggestion) {
                return ListTile(
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: AppColors.neonCyan,
                    size: 20,
                  ),
                  title: Text(
                    suggestion,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.warmWhite,
                    ),
                  ),
                  onTap: () => _onSuggestionSelected(suggestion),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }
}