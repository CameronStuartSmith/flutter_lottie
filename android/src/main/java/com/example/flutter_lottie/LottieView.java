package com.example.flutter_lottie;

import android.animation.Animator;
import android.content.Context;
import android.graphics.Color;
import android.view.View;
import com.airbnb.lottie.LottieAnimationView;
import com.airbnb.lottie.LottieProperty;
import com.airbnb.lottie.model.KeyPath;
import com.airbnb.lottie.value.LottieValueCallback;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.platform.PlatformView;
import java.util.Map;

public class LottieView implements PlatformView, MethodChannel.MethodCallHandler {
    private final Context mContext;
    private final int mId;
    private final Object mArgs;
    private final Registrar mRegistrar;
    private final LottieAnimationView animationView;

    private float maxFrame;
    private MethodChannel channel;
    private EventChannel.EventSink onPlaybackFinishEvent;

    LottieView(Context context, int id, Object args, Registrar registrar) {
        super();
        mContext = context;
        mId = id;
        mArgs = args;
        mRegistrar = registrar;
        animationView = new LottieAnimationView(context);

        Map<String, Object> params = (Map<String, Object>) args;
        create(params);

    }

    void create(Map<String, Object> args) {

        channel = new MethodChannel(mRegistrar.messenger(), "convictiontech/flutter_lottie_" + mId);
        channel.setMethodCallHandler(this);

        final EventChannel onPlaybackCompleteEventChannel = new EventChannel(mRegistrar.messenger(), "convictiontech/flutter_lottie_stream_playfinish_" + mId);

        onPlaybackCompleteEventChannel.setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object o, EventChannel.EventSink eventSink) {
                onPlaybackFinishEvent = eventSink;
            }

            @Override
            public void onCancel(Object o) {

            }
        });


        if(args.get("url") != null) {
            animationView.setAnimationFromUrl(args.get("url").toString());
        }

        if(args.get("filePath") != null) {
            String key = mRegistrar.lookupKeyForAsset(args.get("filePath").toString());
            animationView.setAnimation(key);
        }

        boolean loop, reverse, autoPlay;

        loop = ((args.get("loop")) != null) ? Boolean.parseBoolean(args.get("loop").toString()) : false;
        reverse = ((args.get("reverse")) != null) ? Boolean.parseBoolean(args.get("reverse").toString()) : false;
        autoPlay = ((args.get("autoPlay")) != null) ? Boolean.parseBoolean(args.get("autoPlay").toString()) : false;

        animationView.setRepeatCount(loop ? -1 : 0);

        maxFrame = animationView.getMaxFrame();

        if(reverse) {
            animationView.setRepeatMode(2);
        } else {
            animationView.setRepeatMode(1);
        }

        if(autoPlay) {
            animationView.playAnimation();
        }


        animationView.addAnimatorListener(new Animator.AnimatorListener() {
            @Override
            public void onAnimationStart(Animator animation) {
            }

            @Override
            public void onAnimationEnd(Animator animation) {
                if(onPlaybackFinishEvent != null) {
                    onPlaybackFinishEvent.success(true);
                }
            }

            @Override
            public void onAnimationCancel(Animator animation) {
                if(onPlaybackFinishEvent != null) {
                    onPlaybackFinishEvent.success(false);
                }
            }

            @Override
            public void onAnimationRepeat(Animator animation) {
            }
        });

    }

    @Override
    public View getView() {
        return animationView;
    }

    @Override
    public void dispose() {
        animationView.cancelAnimation();
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        Map<String, Object> args = (Map<String, Object>) call.arguments;
        switch(call.method) {
            case "play":
                animationView.setMinAndMaxFrame(0, (int) maxFrame);
                animationView.setMinAndMaxProgress(0, 1);
                animationView.playAnimation();
                break;
            case "resume":
                animationView.resumeAnimation();
                break;
            case "playWithProgress":
                if(args.containsKey("fromProgress") && args.get("fromProgress") != null) {
                    final float fromProgress = ((Double) args.get("fromProgress")).floatValue();
                    animationView.setMinProgress(fromProgress);
                }

                if(args.get("toProgress") != null) {
                    final float toProgress = ((Double) args.get("toProgress")).floatValue();
                    animationView.setMaxProgress(toProgress);
                }
                animationView.playAnimation();
                break;
            case "playWithFrames":
                if(args.get("fromFrame") != null) {
                    final int fromFrame = (int) args.get("fromFrame");
                    animationView.setMinFrame(fromFrame);
                }

                if(args.get("toFrame") != null) {
                    final int toFrame = (int) args.get("toFrame");
                    animationView.setMaxFrame(toFrame);
                }
                animationView.playAnimation();
                break;
            case "stop":
                animationView.cancelAnimation();
                animationView.setProgress(0.0f);
                final int mode = animationView.getRepeatMode();
                animationView.setRepeatMode(1);
                animationView.setRepeatMode(mode);
                break;
            case "pause":
                animationView.pauseAnimation();
                break;
            case "setAnimationSpeed":
                animationView.setSpeed(Float.parseFloat(args.get("speed").toString()));
                break;
            case "setLoopAnimation":
                boolean loop = ((args.get("loop")) != null) ? Boolean.parseBoolean(args.get("loop").toString()) : false;
                animationView.setRepeatCount(loop ? -1 : 0);
                break;
            case "setAutoReverseAnimation":
                boolean reverse = ((args.get("reverse")) != null) ? Boolean.parseBoolean(args.get("reverse").toString()) : false;
                if(reverse) {
                    animationView.setRepeatMode(2);
                } else {
                    animationView.setRepeatMode(1);
                }
                break;
            case "setAnimationProgress":
                animationView.pauseAnimation(); // TODO Make sure its consistant with iOS
                animationView.setProgress(Float.parseFloat(args.get("progress").toString()));
                break;
            case "setProgressWithFrame":
                animationView.setFrame(Integer.parseInt(args.get("progress").toString()));
                break;
            case "isAnimationPlaying":
                result.success(animationView.isAnimating());
                break;
            case "getAnimationDuration":
                result.success((double)animationView.getDuration());
                break;
            case "getAnimationProgress":
                result.success((double)animationView.getProgress());
                break;
            case "getAnimationSpeed":
                result.success((double)animationView.getSpeed());
                break;
            case "getLoopAnimation":
                result.success(animationView.getRepeatCount() == -1 ? true : false);
                break;
            case "getAutoReverseAnimation":
                result.success(animationView.getRepeatMode() == 2 ? true : false);
                break;
            case "setValue":
                final String value = args.get("value").toString();
                final String keyPath = args.get("keyPath").toString();
                final String type = args.get("type").toString();
                setValue(type, value, keyPath);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void setValue(String type, String value, String keyPath) {
        String[] keyPaths = keyPath.split("\\.");
        switch (type) {
            case "LOTColorValue":
                animationView.addValueCallback(
                        new KeyPath(keyPaths),
                        LottieProperty.COLOR,
                        new LottieValueCallback<>(convertColor(value))
                );
                break;
            case "LOTOpacityValue":
                float v = Float.parseFloat(value) * 100;
                animationView.addValueCallback(
                    new KeyPath(keyPaths),
                    LottieProperty.OPACITY,
                    new LottieValueCallback<>(Math.round(v))
                );
                break;
            default:
                break;
        }
    }

//    private int getOpacity(String value) {
//        return Integer.valueOf(value.substring(2,4), 16);
//    }

    private int convertColor(String value) {
//        float alpha = Integer.valueOf(value.substring(2,4), 16);
        float red = Integer.valueOf(value.substring(4,6), 16);
        float green = Integer.valueOf(value.substring(6,8), 16);
        float blue = Integer.valueOf(value.substring(8,10), 16);
        return Color.argb(255, (int) red, (int) green, (int) blue);
    }
}
