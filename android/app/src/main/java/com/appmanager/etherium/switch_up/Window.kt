package com.applockFlutter

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.PixelFormat
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.*
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.android.FlutterFragment

@SuppressLint("InflateParams")
class Window : AppCompatActivity() {
    private var mView: View? = null
    private var mParams: WindowManager.LayoutParams? = null
    private var mWindowManager: WindowManager? = null

    private val TAG_FLUTTER_FRAGMENT = "flutter_fragment"
    private var flutterFragment: FlutterFragment? = null

    @SuppressLint("CommitTransaction")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        mWindowManager = getSystemService(Context.WINDOW_SERVICE) as WindowManager

        mParams = WindowManager.LayoutParams(
            WindowManager.LayoutParams.MATCH_PARENT,
            WindowManager.LayoutParams.MATCH_PARENT,
            WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY,
            WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN,
            PixelFormat.TRANSLUCENT
        )

        mParams!!.gravity = Gravity.CENTER

        mView = layoutInflater.inflate(R.layout.flutter_game, null)

        flutterFragment =
            supportFragmentManager.findFragmentByTag(TAG_FLUTTER_FRAGMENT) as FlutterFragment?

        if (flutterFragment == null) {
            flutterFragment = FlutterFragment.createDefault()
            supportFragmentManager.beginTransaction().add(
                R.id.flutter_game_fragment, flutterFragment!!, TAG_FLUTTER_FRAGMENT
            ).commit()
        }
    }

    fun open() {
        try {
            if (mView?.windowToken == null) {
                if (mView?.parent == null) {
                    windowManager.addView(mView, mParams)
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    fun isOpen(): Boolean {
        return (mView?.windowToken != null && mView?.parent != null)
    }

    fun close() {
        try {
            Handler(Looper.getMainLooper()).postDelayed({
                (getSystemService(Context.WINDOW_SERVICE) as WindowManager).removeView(mView)
                mView?.invalidate()
            }, 500)

        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    fun doneButton() {

    }

}