package com.example.babay_pro

import android.os.Bundle
import android.os.PersistableBundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result
import android.util.Log

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.baby/native"
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        print("oncreat----")
        Log.d("Tag","oncreat")
    }
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        print("configureFlutterEngine----")
        Log.d("Tag","configureFlutterEngine")
        // 创建 MethodChannel
        val methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        // 设置方法调用处理器
        methodChannel.setMethodCallHandler { call, result ->
            Log.d("Tag","${call.method}")
            when (call.method) {
                "opnCarama" -> {
                    result.success("succes from Android ${android.os.Build.VERSION.RELEASE}")
                }
                // 添加其他方法处理
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}