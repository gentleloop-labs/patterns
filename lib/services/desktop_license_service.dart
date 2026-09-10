import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

/// Compile-time desktop commerce values.
///
/// They are deliberately empty by default. A release build must provide the
/// live checkout URL and the numeric Lemon Squeezy product ID; otherwise the
/// UI stays visible but cannot sell or activate an unrelated license.
abstract final class DesktopCommerceConfiguration {
  static const checkoutUrl = String.fromEnvironment(
    'PATTERNS_DESKTOP_CHECKOUT_URL',
  );
  static const licenseProductId = String.fromEnvironment(
    'PATTERNS_DESKTOP_LICENSE_PRODUCT_ID',
  );
  static const priceLabel = String.fromEnvironment(
    'PATTERNS_DESKTOP_PRICE_LABEL',
    defaultValue: 'US\$9.99',
  );

  static Uri? parseCheckoutUrl(String value) {
    final uri = Uri.tryParse(value);
    return uri != null &&
            uri.isScheme('https') &&
            uri.hasAuthority &&
            uri.host.isNotEmpty
        ? uri
        : null;
  }

  static Uri? get checkoutUri => parseCheckoutUrl(checkoutUrl);
}

enum DesktopLicenseActivationStatus {
  activated,
  invalid,
  rejected,
  unavailable,
  notConfigured,
}

/// Activates a Windows/Linux license through Lemon Squeezy's public License
/// API. No API secret is embedded in the app. The response must belong to the
/// product ID compiled into this build before the caller grants Pro access.
class DesktopLicenseService {
  static final Uri _activationUri = Uri.https(
    'api.lemonsqueezy.com',
    '/v1/licenses/activate',
  );

  const DesktopLicenseService();

  Future<DesktopLicenseActivationStatus> activate(
    String licenseKey, {
    http.Client? client,
    String expectedProductId = DesktopCommerceConfiguration.licenseProductId,
  }) async {
    final key = licenseKey.trim();
    if (key.isEmpty) return DesktopLicenseActivationStatus.invalid;
    if (expectedProductId.trim().isEmpty) {
      return DesktopLicenseActivationStatus.notConfigured;
    }

    final ownsClient = client == null;
    final requestClient = client ?? http.Client();
    try {
      final response = await requestClient
          .post(
            _activationUri,
            headers: const {
              'Accept': 'application/json',
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: {
              'license_key': key,
              // Avoid sending a device or account name. License activation
              // needs a label, not personal information.
              'instance_name': 'Patterns Desktop',
            },
          )
          .timeout(const Duration(seconds: 12));
      if (response.statusCode < 200 || response.statusCode >= 300) {
        return DesktopLicenseActivationStatus.rejected;
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic> || decoded['activated'] != true) {
        return DesktopLicenseActivationStatus.rejected;
      }
      final license = decoded['license_key'];
      final meta = decoded['meta'];
      if (license is! Map<String, dynamic> ||
          license['status'] != 'active' ||
          meta is! Map<String, dynamic> ||
          meta['product_id']?.toString() != expectedProductId) {
        return DesktopLicenseActivationStatus.rejected;
      }
      return DesktopLicenseActivationStatus.activated;
    } on TimeoutException {
      return DesktopLicenseActivationStatus.unavailable;
    } on FormatException {
      return DesktopLicenseActivationStatus.unavailable;
    } catch (_) {
      return DesktopLicenseActivationStatus.unavailable;
    } finally {
      if (ownsClient) requestClient.close();
    }
  }
}
