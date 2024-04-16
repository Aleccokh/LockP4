package com.applockFlutter

import android.annotation.SuppressLint
import android.content.Context
import android.content.SharedPreferences
import android.graphics.PixelFormat
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.*
import android.view.View.OnClickListener
import android.widget.Button
import android.widget.EditText
import android.widget.TextView


@SuppressLint("InflateParams")
class Window(
    private val context: Context
) {
    private val mView: View
    var result: String = ""
    private var mParams: WindowManager.LayoutParams? = null
    private val mWindowManager: WindowManager
    private val layoutInflater: LayoutInflater

    private var mGameResult: EditText? = null
    private var mGameValidate: Button? = null

    private val mOnClickListener: OnClickListener = OnClickListener { view ->
        result = (view as EditText).text.toString()
        Log.d(PinCodeActivity.TAG, "Pin complete: $result")
        doneButton()
    }

    fun open() {
        try {
            if (mView.windowToken == null) {
                if (mView.parent == null) {
                    mWindowManager.addView(mView, mParams)
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    fun isOpen(): Boolean {
        return (mView.windowToken != null && mView.parent != null)
    }

    fun close() {
        try {
            Handler(Looper.getMainLooper()).postDelayed({
                (context.getSystemService(Context.WINDOW_SERVICE) as WindowManager).removeView(mView)
                mView.invalidate()
            }, 500)

        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    fun doneButton() {
        try {
            val saveAppData: SharedPreferences =
                context.getSharedPreferences("save_app_data", Context.MODE_PRIVATE)
            if (result.toInt() == 8) {
                println("$result---------------pincode")
                close()
            }
        } catch (e: Exception) {
            println("$e---------------doneButton")
        }
    }

    init {

        mParams = WindowManager.LayoutParams(
            WindowManager.LayoutParams.MATCH_PARENT,
            WindowManager.LayoutParams.MATCH_PARENT,
            WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY,
            WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN,
            PixelFormat.TRANSLUCENT
        )
        layoutInflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
        mView = layoutInflater.inflate(R.layout.flutter_game, null)

        mParams!!.gravity = Gravity.CENTER
        mWindowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager

        mGameResult = mView.findViewById(R.id.game_result)
        mGameValidate = mView.findViewById(R.id.game_validate)

        mGameValidate!!.setOnClickListener(mOnClickListener)
    }

}