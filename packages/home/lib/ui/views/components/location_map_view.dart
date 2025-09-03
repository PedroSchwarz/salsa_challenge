import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum MapEventType {
  mapLoaded('Map Loaded Successfully'),
  locationClicked('Location clicked!'),
  error('Error occurred');

  const MapEventType(this.message);
  final String message;
}

class LocationMapView extends StatefulWidget {
  const LocationMapView({super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  State<LocationMapView> createState() => _LocationMapViewState();
}

class _LocationMapViewState extends State<LocationMapView> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;

  // Cache for HTML content to avoid rebuilding
  static String? _cachedHtmlContent;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(Colors.transparent)
          ..addJavaScriptChannel('FlutterChannel', onMessageReceived: _handleMessage)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                if (mounted) {
                  setState(() {
                    _isLoading = true;
                    _hasError = false;
                  });
                }
              },
              onPageFinished: (url) async {
                await _setLocation();
                if (mounted) {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              onWebResourceError: (error) {
                if (mounted) {
                  setState(() {
                    _isLoading = false;
                    _hasError = true;
                    _errorMessage = error.description;
                  });
                  _showSnackBar(MapEventType.error.message);
                }
              },
            ),
          );

    _loadContent();
  }

  void _loadContent() {
    try {
      final htmlContent = _cachedHtmlContent ?? _buildHtmlContent();
      _cachedHtmlContent = htmlContent;

      _controller.loadRequest(Uri.dataFromString(htmlContent, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')));
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = e.toString();
        });
      }
    }
  }

  Future<void> _setLocation() async {
    try {
      await _controller.runJavaScript("setLocation(${widget.latitude}, ${widget.longitude});");
    } catch (e) {
      debugPrint("Error setting location: $e");
      if (mounted) {
        _showSnackBar("Error setting map location");
      }
    }
  }

  void _handleMessage(JavaScriptMessage msg) {
    try {
      final data = jsonDecode(msg.message);
      final eventType = data['event'] as String?;

      final event = MapEventType.values.firstWhere((e) => e.message == eventType, orElse: () => MapEventType.error);

      _showSnackBar(event.message);
    } catch (e) {
      debugPrint("Error parsing message: $e");
      _showSnackBar(MapEventType.error.message);
    }
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), duration: const Duration(seconds: 2)));
    }
  }

  @override
  void dispose() {
    _controller.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Container(
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(16)),
              child: const Center(child: CircularProgressIndicator()),
            ),
          if (_hasError)
            Container(
              decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: Colors.red[400], size: 48),
                    const SizedBox(height: 16),
                    Text('Failed to load map', style: TextStyle(color: Colors.red[600], fontSize: 16, fontWeight: FontWeight.w500)),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(_errorMessage!, style: TextStyle(color: Colors.red[500], fontSize: 12), textAlign: TextAlign.center),
                      ),
                    ],
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _hasError = false;
                          _isLoading = true;
                        });
                        _loadContent();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

String _buildHtmlContent() {
  return '''
    <!DOCTYPE html>
    <html>

    <head>
        <title>Flutter WebView Maps</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body, html {
                margin: 0;
                padding: 0;
                height: 100%;
                width: 100%;
            }
            #mapFrame {
                width: 100%;
                height: 100vh;
                border: 0;
            }
        </style>
        <script>
            function setLocation(lat, lng) {
                const iframe = document.getElementById("mapFrame");
                iframe.src = `https://www.google.com/maps/embed/v1/place?key=AIzaSyB41DRUbKWJHPxaFjMAwdrzWzbVKartNGg&q=\${lat},\${lng}&zoom=15`;
            }

            function sendMessageToFlutter(msg) {
                if (window.FlutterChannel) {
                    window.FlutterChannel.postMessage(JSON.stringify({ event: msg }));
                }
            }

            function notifyMapLoaded() {
                sendMessageToFlutter("Map Loaded Successfully");
            }

            // Trigger the event when DOM is loaded
            document.addEventListener('DOMContentLoaded', function() {
                notifyMapLoaded();
            });
        </script>
    </head>

    <body>
        <iframe id="mapFrame" allowfullscreen loading="lazy">
        </iframe>
    </body>

    </html>
    ''';
}
