import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:internir/services/api_client.dart';

Future<String> getFullDescription(String id) async {
  final response = await http.get(Uri.parse(APIClient.baseUrlDetails + id));

  if (response.statusCode == 200) {
    var document = parser.parse(response.body);

    // Select the full job description using the class you provided
    var descriptionElement = document
        .querySelector('.adp-body.mx-4.text-sm.md\\:mx-0.md\\:text-base');

    if (descriptionElement != null) {
      // Convert the HTML content into plain text
      String description = descriptionElement.innerHtml
          .replaceAll('<li>', "  *")
          .replaceAll('<br>', '\n') // Convert <br> tags to newlines
          .replaceAll(RegExp(r'<.*?>'), ''); // Remove any remaining HTML tags

      return description.trim();
    } else {
      return 'Description not found';
    }
  } else {
    throw Exception('Failed to load job page');
  }
}

String timeFormat(String time) {
  // Parse the UTC time
  DateTime utcDateTime = DateTime.parse(time);

  // Convert to local time
  DateTime localDateTime = utcDateTime.toLocal();

  return "${localDateTime.day}/${localDateTime.month}/${localDateTime.year}";
}
