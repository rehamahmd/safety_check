package com.example.safety_check.Debugging;
import android.app.Activity
import android.os.Build;
import android.provider.Settings


class DebuggingCheck {
    private var activity: Activity? = null

    constructor(activity: Activity?) {
      this.activity = activity
    }
     // is Debuggable
  public fun isDebuggable(debug : Boolean): Boolean{
    if (debug || (Settings.Global.getInt(this.activity!!.getContentResolver(), Settings.Global.ADB_ENABLED, 0) == 1)) {
        return true;
    }
    return false; 
  }

}