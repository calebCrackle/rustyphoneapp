package com.rustyphoneapp

import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod

import android.util.Log

class RustBridge(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
    init {
        System.loadLibrary("rustyphoneapp")
    }

    override fun getName() = "RustBridge"

    @ReactMethod
    fun invoke(request: String, promise: Promise) {
        promise.resolve(rustInvoke(request));
    }

    private external fun rustInvoke(request: String): String
}
