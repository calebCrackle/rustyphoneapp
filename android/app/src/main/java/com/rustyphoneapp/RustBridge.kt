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
    fun logevent(name: String, location: String, promise: Promise) {
        Log.d("CalendarModule", "Create event called with name: $name and location: $location");
        promise.resolve(helloWorld("FunnyHats"));
    }

    private external fun helloWorld(seed: String): String
}
