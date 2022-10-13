package com.example.safety_check.Tampering;

import android.app.Activity
import android.os.Build;
import android.content.pm.ApplicationInfo
import android.annotation.SuppressLint

import android.util.Log;
import kotlin.system.exitProcess
import android.provider.Settings
import android.widget.Toast
import java.security.MessageDigest
import android.content.pm.PackageManager

class TamperingCheck {
  private var activity: Activity? = null

  constructor(activity: Activity?) {
    this.activity = activity
    }
     // is Hooked
  public fun isTampered(signatureKey:String) : Boolean {
    return checkSignature(signatureKey);
  }

    // is Tampered
    private fun checkSignature(sha: String) : Boolean{

        var signatureList = getApplicationSignature(this.activity!!.packageName)
        if (signatureList.contains(sha)) {
            println(signatureList);
            println(signatureList);
            // result.success("notTampered")
            return false;
        } else {
            return true;
        }
      }
    
      // For Signature
      @SuppressLint("PackageManagerGetSignatures")
      fun getApplicationSignature(packageName: String): List<String> {
          val signatureList: List<String>
          try {
              if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                  // New signature
                  val sig = this.activity!!.packageManager.getPackageInfo(packageName, PackageManager.GET_SIGNING_CERTIFICATES).signingInfo
                  signatureList = if (sig.hasMultipleSigners()) {
                      // Send all with apkContentsSigners
                      
                      sig.apkContentsSigners.map {
                          val digest = MessageDigest.getInstance("SHA")
                          digest.update(it.toByteArray())
                          bytesToHex(digest.digest())
                      }
                  } else {
                      // Send one with signingCertificateHistory
                      sig.signingCertificateHistory.map {
                          val digest = MessageDigest.getInstance("SHA")
                          digest.update(it.toByteArray())
                          bytesToHex(digest.digest())
                      }
                  }
              } else {
    
                  val sig = this.activity!!.packageManager.getPackageInfo(packageName, PackageManager.GET_SIGNATURES).signatures
                  signatureList = sig.map {
                      val digest = MessageDigest.getInstance("SHA")
                      digest.update(it.toByteArray())
                      bytesToHex(digest.digest())
                  }
              }
    
              return signatureList
          } catch (e: Exception) {
              // Handle error
              Log.d("error", e.toString())
              // result.success("genericError")
          }
          return emptyList()
      }
      private fun bytesToHex(bytes: ByteArray): String {
          val hexArray = charArrayOf('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F')
          val hexChars = CharArray(bytes.size * 2)
          var v: Int
          for (j in bytes.indices) {
              v = bytes[j].toInt() and 0xFF
              hexChars[j * 2] = hexArray[v.ushr(4)]
              hexChars[j * 2 + 1] = hexArray[v and 0x0F]
          }
          return String(hexChars)
      }

}