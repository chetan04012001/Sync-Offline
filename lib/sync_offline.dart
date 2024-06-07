
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';

Future<void> handleDataSync({
  required BuildContext context,
  required Map<String, TextEditingController> controllers,
  required SnackBar successSnackBar,
  required ValueNotifier<bool> isPostingOnline,
  required dynamic dbHelper,
  required dynamic apiService,
  required Widget destinationScreen,
}) async {
  try {
    final int insertedId = await _insertFormData(
      dbHelper: dbHelper,
      controllers: controllers,
    );
    await _handleInternetConnectivity(
      context: context,
      insertedId: insertedId,
      controllers: controllers,
      successSnackBar: successSnackBar,
      isPostingOnline: isPostingOnline,
      dbHelper: dbHelper,
      apiService: apiService,
      destinationScreen: destinationScreen,
    );
  } catch (e) {
    _showErrorSnackBar(context);
    print('Error: $e');
  }
}

Future<int> _insertFormData({
  required dynamic dbHelper,
  required Map<String, TextEditingController> controllers,
}) async {
  return await dbHelper.insertData(
    controllers['name']?.text ?? '',
    controllers['job']?.text ?? '',
    controllers['email']?.text ?? '',
    controllers['mobile']?.text ?? '',
    controllers['address']?.text ?? '',
  );
}

Future<void> _handleInternetConnectivity({
  required BuildContext context,
  required int insertedId,
  required Map<String, TextEditingController> controllers,
  required SnackBar successSnackBar,
  required ValueNotifier<bool> isPostingOnline,
  required dynamic dbHelper,
  required dynamic apiService,
  required Widget destinationScreen,
}) async {
  final ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();

  if (connectivityResult != ConnectivityResult.none) {
    _postFormData(
      context: context,
      insertedId: insertedId,
      controllers: controllers,
      successSnackBar: successSnackBar,
      isPostingOnline: isPostingOnline,
      dbHelper: dbHelper,
      apiService: apiService,
      destinationScreen: destinationScreen,
    );
  } else {
    _waitForInternetAndRetry(
      context: context,
      insertedId: insertedId,
      controllers: controllers,
      successSnackBar: successSnackBar,
      isPostingOnline: isPostingOnline,
      dbHelper: dbHelper,
      apiService: apiService,
      destinationScreen: destinationScreen,
    );
  }
}

Future<void> _postFormData({
  required BuildContext context,
  required int insertedId,
  required Map<String, TextEditingController> controllers,
  required SnackBar successSnackBar,
  required ValueNotifier<bool> isPostingOnline,
  required dynamic dbHelper,
  required dynamic apiService,
  required Widget destinationScreen,
}) async {
  isPostingOnline.value = true;

  try {
    // Simulating an API call
    await Future.delayed(Duration(seconds: 2));

    // Update database status
    await dbHelper.updateStatus(insertedId, 2);
    ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => destinationScreen));
  } catch (e) {
    _showErrorSnackBar(context);
    print('Error posting data: $e');
  } finally {
    isPostingOnline.value = false;
  }
}

Future<void> _waitForInternetAndRetry({
  required BuildContext context,
  required int insertedId,
  required Map<String, TextEditingController> controllers,
  required SnackBar successSnackBar,
  required ValueNotifier<bool> isPostingOnline,
  required dynamic dbHelper,
  required dynamic apiService,
  required Widget destinationScreen,
}) async {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('No Internet, please wait: Data fetching from local DB'),
    ),
  );

  Timer.periodic(const Duration(seconds: 5), (timer) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      timer.cancel();
      await _postFormData(
        context: context,
        insertedId: insertedId,
        controllers: controllers,
        successSnackBar: successSnackBar,
        isPostingOnline: isPostingOnline,
        dbHelper: dbHelper,
        apiService: apiService,
        destinationScreen: destinationScreen,
      );
    }
  });
}

void _showErrorSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('An error occurred'),
      backgroundColor: Colors.red,
    ),
  );
}

