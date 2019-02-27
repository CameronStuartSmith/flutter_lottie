import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'lotvalues/lot_value.dart';

class LottieController {
  int id;
  MethodChannel _channel;
  EventChannel _playFinished;

  LottieController(int id) {
    this.id = id;
    print('Creating Method Channel convictiontech/flutter_lottie_$id');
    this._channel = new MethodChannel('convictiontech/flutter_lottie_$id');
    this._playFinished = EventChannel('convictiontech/flutter_lottie_stream_playfinish_$id');
  }

  Future<void> setLoopAnimation(bool loop) async {
    assert(loop != null);
    return _channel.invokeMethod('setLoopAnimation', { "loop": loop });
  }

  Future<void> setAutoReverseAnimation(bool reverse) async {
    assert(reverse != null);
    return _channel.invokeMethod('setAutoReverseAnimation', { "reverse": reverse });
  }

  Future<void> play() async {
    return _channel.invokeMethod('play');
  }

  Future<void> playWithProgress({double fromProgress, double toProgress}) async {
    assert(toProgress != null);
    return _channel.invokeMethod('playWithProgress', { "fromProgress": fromProgress,  "toProgress": toProgress });
  }

  Future<void> playWithFrames({int fromFrame, int toFrame}) async {
    assert(toFrame != null);
    return _channel.invokeMethod('playWithFrames', { "fromFrame": fromFrame,  "toFrame": toFrame });
  }

  Future<void> stop() async {
    return _channel.invokeMethod('stop');
  }

  Future<void> pause() async {
    return _channel.invokeMethod('pause');
  }

  Future<void> resume() async {
    return _channel.invokeMethod('resume');
  }

  Future<void> setAnimationSpeed(double speed) async {
    return _channel.invokeMethod('setAnimationSpeed', { "speed": speed.clamp(0, 1) });
  }

  Future<void> setAnimationProgress(double progress) async {
    return _channel.invokeMethod('setAnimationProgress', { "progress": progress.clamp(0, 1) });
  }

  Future<void> setProgressWithFrame(int frame) async {
    return _channel.invokeMethod('setProgressWithFrame', { "frame": frame });
  }

  Future<double> getAnimationDuration() async {
    return _channel.invokeMethod('getAnimationDuration');
  }

  Future<double> getAnimationProgress() async {
    return _channel.invokeMethod('getAnimationProgress');
  }

  Future<double> getAnimationSpeed() async {
    return _channel.invokeMethod('getAnimationSpeed');
  }

  Future<bool> isAnimationPlaying() async {
    return _channel.invokeMethod('isAnimationPlaying');
  }

  Future<bool> getLoopAnimation() async {
    return _channel.invokeMethod('getLoopAnimation');
  }

  Future<bool> getAutoReverseAnimation() async {
    return _channel.invokeMethod('getAutoReverseAnimation');
  }

  Future<void> setValue({ LOTValue value, @required String keyPath }) async {
    assert(value != null); assert(keyPath != null);
    return _channel.invokeMethod('setValue', {
      "value": value.value,
      "type": value.type,
      "keyPath": keyPath,
    });
  }

  Stream<bool> get onPlayFinished {
    var animationFinished = _playFinished
        .receiveBroadcastStream()
        .map<bool>(
            (element) => element);
    return animationFinished;
  }

}