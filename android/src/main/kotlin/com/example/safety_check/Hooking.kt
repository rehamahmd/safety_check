package com.example.safety_check.Hooking;
import android.app.Activity
import android.os.Build;
import android.content.pm.ApplicationInfo

class HookingCheck {
  private var activity: Activity? = null

  constructor(activity: Activity?) {
    this.activity = activity
    }
     // is Hooked
  public fun isHooked() : Boolean {
    val list = this.activity!!.packageManager.getInstalledPackages(0)
    for (i in list.indices) {
        val packageInfo = list[i]
        if (packageInfo!!.applicationInfo.flags and ApplicationInfo.FLAG_SYSTEM == 0) {
           val appName = packageInfo.applicationInfo.loadLabel(this.activity!!.packageManager).toString()
           if(appName == "Magisk" || appName == "Frida" || appName == "Xposed"  || appName == "SuperSU" ||
           appName == "Kingoroot" ||
           list[i].packageName == "eu.chainfire.supersu" || list[i].packageName == "com.jozein.xedge" || 
           list[i].packageName == "com.joeykrim.rootcheck" || list[i].packageName == "de.robv.android.xposed.installer"
           || list[i].packageName == "com.saurik.substrate"
           ){
            return true;
           }
        }
     }
     return false;
  }

}