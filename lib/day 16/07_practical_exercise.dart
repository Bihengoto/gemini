// Day 16: Practical Exercise - Building a Simple App with Packages
// ================================================================

/*
PRACTICAL EXERCISE: QUOTE OF THE DAY APP

We'll build a simple app that demonstrates package usage:
- Uses http package for API requests
- Uses shared_preferences for local storage
- Uses intl package for date formatting

FEATURES:
1. Fetch random quotes from an API
2. Save favorite quotes locally
3. Display formatted dates
4. Simple error handling

TO COMPLETE THIS EXERCISE:
1. Add these packages to pubspec.yaml:
   dependencies:
     http: ^1.1.0
     shared_preferences: ^2.2.2
     intl: ^0.19.0

2. Run: flutter pub get

3. Uncomment the import statements below

4. Test the functionality
*/

import 'dart:convert';
import 'dart:math';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';

class Quote {
  final String text;
  final String author;
  final DateTime fetchedAt;

  Quote({required this.text, required this.author, required this.fetchedAt});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'author': author,
      'fetchedAt': fetchedAt.toIso8601String(),
    };
  }

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      text: json['text'],
      author: json['author'],
      fetchedAt: DateTime.parse(json['fetchedAt']),
    );
  }
}

class QuoteService {
  static const String apiUrl = 'https://api.quotable.io/random';

  // Fetch random quote from API
  static Future<Quote?> fetchRandomQuote() async {
    print('Fetching random quote from API...');

    // Uncomment when http package is added:
    /*
    try {
      final response = await http.get(Uri.parse(apiUrl));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Quote(
          text: data['content'],
          author: data['author'],
          fetchedAt: DateTime.now(),
        );
      } else {
        print('API Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Network error: $e');
      return null;
    }
    */

    // Simulated quotes for demonstration
    List<Map<String, String>> sampleQuotes = [
      {
        'text': 'The only way to do great work is to love what you do.',
        'author': 'Steve Jobs',
      },
      {
        'text': 'Innovation distinguishes between a leader and a follower.',
        'author': 'Steve Jobs',
      },
      {
        'text':
            'Life is what happens to you while you\'re busy making other plans.',
        'author': 'John Lennon',
      },
      {
        'text':
            'The future belongs to those who believe in the beauty of their dreams.',
        'author': 'Eleanor Roosevelt',
      },
    ];

    final random = Random();
    final selectedQuote = sampleQuotes[random.nextInt(sampleQuotes.length)];

    return Quote(
      text: selectedQuote['text']!,
      author: selectedQuote['author']!,
      fetchedAt: DateTime.now(),
    );
  }
}

class LocalStorage {
  static const String favoritesKey = 'favorite_quotes';

  // Save favorite quotes to local storage
  static Future<void> saveFavoriteQuotes(List<Quote> quotes) async {
    print('Saving ${quotes.length} favorite quotes...');

    // Uncomment when shared_preferences package is added:
    /*
    final prefs = await SharedPreferences.getInstance();
    final quotesJson = quotes.map((quote) => json.encode(quote.toJson())).toList();
    await prefs.setStringList(favoritesKey, quotesJson);
    */

    // Simulated save for demonstration
    print('Quotes saved to local storage');
  }

  // Load favorite quotes from local storage
  static Future<List<Quote>> loadFavoriteQuotes() async {
    print('Loading favorite quotes from local storage...');

    // Uncomment when shared_preferences package is added:
    /*
    final prefs = await SharedPreferences.getInstance();
    final quotesJson = prefs.getStringList(favoritesKey) ?? [];
    
    return quotesJson.map((quoteJson) {
      final data = json.decode(quoteJson);
      return Quote.fromJson(data);
    }).toList();
    */

    // Simulated load for demonstration
    return [
      Quote(
        text: 'Previously saved quote example',
        author: 'Demo Author',
        fetchedAt: DateTime.now().subtract(Duration(days: 1)),
      ),
    ];
  }

  // Add quote to favorites
  static Future<void> addToFavorites(Quote quote) async {
    final favorites = await loadFavoriteQuotes();

    // Check if quote already exists
    bool alreadyExists = favorites.any(
      (fav) => fav.text == quote.text && fav.author == quote.author,
    );

    if (!alreadyExists) {
      favorites.add(quote);
      await saveFavoriteQuotes(favorites);
      print('Quote added to favorites!');
    } else {
      print('Quote already in favorites');
    }
  }
}

class DateFormatter {
  // Format date using intl package
  static String formatDate(DateTime date) {
    // Uncomment when intl package is added:
    /*
    final formatter = DateFormat('MMMM dd, yyyy \'at\' hh:mm a');
    return formatter.format(date);
    */

    // Simple formatting for demonstration
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }
}

// Main application logic
class QuoteApp {
  static Future<void> run() async {
    print('=== Quote of the Day App ===\n');

    // 1. Fetch a random quote
    print('1. Fetching random quote...');
    final quote = await QuoteService.fetchRandomQuote();

    if (quote != null) {
      print('Quote: "${quote.text}"');
      print('Author: ${quote.author}');
      print('Fetched: ${DateFormatter.formatDate(quote.fetchedAt)}');
      print('Time: ${DateFormatter.formatRelativeTime(quote.fetchedAt)}\n');

      // 2. Add to favorites
      print('2. Adding to favorites...');
      await LocalStorage.addToFavorites(quote);
      print();

      // 3. Show all favorites
      print('3. Loading favorite quotes...');
      final favorites = await LocalStorage.loadFavoriteQuotes();
      print(
        'You have ${favorites.length} favorite quote${favorites.length == 1 ? '' : 's'}:',
      );

      for (int i = 0; i < favorites.length; i++) {
        final fav = favorites[i];
        print('${i + 1}. "${fav.text}" - ${fav.author}');
        print('   Saved: ${DateFormatter.formatRelativeTime(fav.fetchedAt)}');
      }
    } else {
      print('Failed to fetch quote. Check your internet connection.');
    }
  }
}

void main() async {
  await QuoteApp.run();

  print('\n=== Exercise Complete! ===');
  print('You\'ve learned how to:');
  print('✓ Use the http package for API requests');
  print('✓ Use shared_preferences for local storage');
  print('✓ Use intl package for date formatting');
  print('✓ Handle errors gracefully');
  print('✓ Structure code with multiple packages');
}
