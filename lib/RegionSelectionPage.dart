import 'package:flutter/material.dart';

class RegionSelectionPage extends StatefulWidget {
  @override
  _RegionSelectionPageState createState() => _RegionSelectionPageState();
}

class _RegionSelectionPageState extends State<RegionSelectionPage> {
  String? selectedRegion;
  String? selectedDistrict;

  final Map<String, List<String>> regions = {
    'Toshkent': ['Mirzo Ulugbek', 'Chilonzor', 'Bektemir', 'Yunusobod'],
    'Samarqand': ['Samarqand sh.', 'Urgut', 'Jomboy', 'Bulung‘ur'],
    'Buxoro': ['Buxoro sh.', 'G‘ijduvon', 'Kogon', 'Shofirkon'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Region and District'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedRegion,
              hint: Text('Select Region'),
              isExpanded: true,
              items: regions.keys.map((region) {
                return DropdownMenuItem<String>(
                  value: region,
                  child: Text(region),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRegion = value;
                  selectedDistrict = null; // Reset district when region changes
                });
              },
            ),
            if (selectedRegion != null)
              DropdownButton<String>(
                value: selectedDistrict,
                hint: Text('Select District'),
                isExpanded: true,
                items: regions[selectedRegion]!.map((district) {
                  return DropdownMenuItem<String>(
                    value: district,
                    child: Text(district),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDistrict = value;
                  });
                },
              ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (selectedRegion != null && selectedDistrict != null) {
                  Navigator.pop(context, {
                    'region': selectedRegion!,
                    'district': selectedDistrict!,
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select both region and district')),
                  );
                }
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
