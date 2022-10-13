package com.example.safety_check.Rooted;

import android.content.Context;

import com.scottyab.rootbeer.RootBeer;
import android.os.Build;

class RootedCheck {
   
     // is Rooted
  public fun isRooted(context: Context): Boolean{
    val rootBeer = RootBeer(context)
    return rootBeer.isRooted; 
  }

}