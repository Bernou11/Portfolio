import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GitHubService {
  final String baseUrl = "https://api.github.com";
  final String? token;
  final String? username;

  GitHubService() : token = dotenv.env['GITHUB_PAT'], username = dotenv.env['GITHUB_USERNAME'];

  Future<Map<String, List<String>>?> getReposSortedByLanguage() async {
    final response = await http.get(
      Uri.parse("$baseUrl/users/$username/repos"),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      List<dynamic> repos = json.decode(response.body);

      Map<String, List<String>> sortedRepos = {
        'java': [],
        'next': [],
        'react': [],
        'node': [],
        'flutter': [],
        'typescript': [],
        'python': [],
        'c': [],
        'c++': [],
        'c#': [],
        'javascript': [],
        'dart': []
      };

      for (var repo in repos) {
        String language = (repo['language'] ?? 'Unknown').toLowerCase();
        List<String> topics = [];

        final topicsResponse = await http.get(
          Uri.parse("$baseUrl/repos/$username/${repo['name']}/topics"),
          headers: _getTopicHeaders(),
        );

        if (topicsResponse.statusCode == 200) {
          topics = List<String>.from(json.decode(topicsResponse.body)['names']);
        }

        print("Repo: ${repo['name']}, Language: $language, Topics: $topics");

        if (language == 'typescript') {
          String? matchedCategory;
          if (topics.any((topic) => topic.toLowerCase() == 'react')) {
            matchedCategory = 'react';
          } else if (topics.any((topic) =>
          topic.toLowerCase() == 'nextjs' ||
              topic.toLowerCase() == 'next')) {
            matchedCategory = 'next';
          } else if (topics.any((topic) =>
          topic.toLowerCase() == 'nodejs' ||
              topic.toLowerCase() == 'node')) {
            matchedCategory = 'node';
          }

          if (matchedCategory != null) {
            sortedRepos[matchedCategory]?.add(repo['name']);
          } else {
            sortedRepos['typescript']?.add(repo['name']);
          }
        } else if (language == 'javascript') {
          String? matchedCategory;
          if (topics.any((topic) => topic.toLowerCase() == 'react')) {
            matchedCategory = 'react';
          } else if (topics.any((topic) =>
          topic.toLowerCase() == 'nextjs' ||
              topic.toLowerCase() == 'next')) {
            matchedCategory = 'next';
          } else if (topics.any((topic) =>
          topic.toLowerCase() == 'nodejs' ||
              topic.toLowerCase() == 'node')) {
            matchedCategory = 'node';
          }

          if (matchedCategory != null) {
            sortedRepos[matchedCategory]?.add(repo['name']);
          } else {
            sortedRepos['javascript']?.add(repo['name']);
          }
        } else if (language == 'dart') {
          String? matchedCategory;
          if (topics.any((topic) => topic.toLowerCase() == 'flutter')) {
            matchedCategory = 'flutter';
          }

          if (matchedCategory != null) {
            sortedRepos[matchedCategory]?.add(repo['name']);
          } else {
            sortedRepos['dart']?.add(repo['name']);
          }
        }
      }

      return sortedRepos;
    } else {
      print("Error: Failed to fetch repositories (Status Code: ${response.statusCode})");
      return null;
    }
  }

  /// Standard headers for repo list request
  Map<String, String> _getHeaders() {
    return token != null
        ? {
      'Authorization': 'token $token',
      'Accept': 'application/vnd.github.v3+json',
    }
        : {
      'Accept': 'application/vnd.github.v3+json',
    };
  }

  /// Special headers to fetch topics (GitHub requires different preview API)
  Map<String, String> _getTopicHeaders() {
    return token != null
        ? {
      'Authorization': 'token $token',
      'Accept': 'application/vnd.github.mercy-preview+json',
    }
        : {
      'Accept': 'application/vnd.github.mercy-preview+json',
    };
  }
}
