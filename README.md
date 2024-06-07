<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Sync offline data Plugin

A Flutter plugin for synchronizing data offline, including form submissions and other data transactions.

## Features

- Allows seamless synchronization of data offline and online.
- Supports dynamic selection of database helper and API service.
- Provides flexibility to specify a custom destination screen upon successful data submission.

## Installation

Add `sync_offline` to your `pubspec.yaml` file:

```yaml
dependencies:
  sync_offline: ^1.0.0

Usage
//Import the package in your Dart code:

import 'package:sync_offline/sync_offline.dart';
//Use the handleDataSync function to synchronize data:

handleDataSync(
  context: context,
  data: {
    'name': nameController.text,
    'email': emailController.text,
  },
  successSnackBar: SnackBar(
    content: Text('Data synchronized successfully'),
  ),
  isSyncing: ValueNotifier(false),
  dbHelper: DBHelper(),
  apiService: ApiService(),
  destinationScreen: CustomDataScreen(), // Specify your custom data screen here
);

