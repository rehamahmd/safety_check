package com.example.safety_check

import android.app.Activity
import android.content.Context;
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.FlutterEngine

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


import com.example.safety_check.Emulator.EmulatorCheck;
import com.example.safety_check.Debugging.DebuggingCheck;
import com.example.safety_check.Hooking.HookingCheck;
import com.example.safety_check.Tampering.TamperingCheck;
import com.example.safety_check.Rooted.RootedCheck;


/** SafetyCheckPlugin */
class SafetyCheckPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {

  private lateinit var channel : MethodChannel
  private var activity: Activity? = null
  private var context: Context? = null
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "safety_check")
    channel.setMethodCallHandler(this)
    this.context = flutterPluginBinding.getApplicationContext();
  }

    // Activity LifeCycle
    // Methods for get Activity
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
      this.activity = binding.activity;
    }
    override fun onDetachedFromActivityForConfigChanges() {}
    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
      onAttachedToActivity(binding)
    }
    override fun onDetachedFromActivity() {
      this.activity = null;
    }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "checkSafety") {
      val signatureKey: String? = call.argument("sha")
      val isDebuggable: Boolean = DebuggingCheck(this.activity).isDebuggable(BuildConfig.DEBUG);
      val isHooked: Boolean = HookingCheck(this.activity).isHooked();
      val isRooted: Boolean = RootedCheck().isRooted(this.context!!);
      val isEmulator: Boolean = EmulatorCheck().isEmulator();
      val isTampered: Boolean = if(signatureKey == null)  false else TamperingCheck(this.activity).isTampered(signatureKey!!) // optional if key exist
      val isSafe: Boolean = !isDebuggable &&  !isHooked && !isEmulator && !isRooted && !isTampered;
      result.success(isSafe)
      return;
    } 
    
    if (call.method == "isDebuggable") {
      val isDebuggable: Boolean = DebuggingCheck(this.activity).isDebuggable(BuildConfig.DEBUG);
      result.success(isDebuggable)
      return;
    } 

    if (call.method == "isHooked") {
      val isHooked: Boolean = HookingCheck(this.activity).isHooked();
      result.success(isHooked)
      return;
    } 

    if(call.method == "isEmulator") {
      val isEmulator: Boolean = EmulatorCheck().isEmulator();
      result.success(isEmulator)
      return;
    }
    if(call.method == "isRooted") {
      val isRooted: Boolean = RootedCheck().isRooted(this.context!!);
      result.success(isRooted)
      return;
    }
    if (call.method == "isTampered") {
      val signatureKey: String? = call.argument("sha")
      println("signatureKey");
      println(signatureKey);
      val isTampered: Boolean = if(signatureKey == null) false else TamperingCheck(this.activity).isTampered(signatureKey!!)
      result.success(isTampered)
      return;
    } 

    result.notImplemented()
    
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    this.context = null;
  }



 








}
