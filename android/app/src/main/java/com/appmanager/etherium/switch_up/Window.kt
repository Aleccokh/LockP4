package com.applockFlutter

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.PixelFormat
import android.os.Handler
import android.os.Looper
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.WindowManager
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import androidx.core.widget.doAfterTextChanged
import kotlin.random.Random


@SuppressLint("InflateParams")
class Window(
    private val context: Context
) {
    private val mView: View
    private var result: String = ""
    private var mParams: WindowManager.LayoutParams? = null
    private val mWindowManager: WindowManager
    private val layoutInflater: LayoutInflater

    private var mGameResult: EditText? = null
    private var mGameValidate: Button? = null
    private var mGameText: TextView? = null

    private var number1 = 0
    private var number2 = 0
    private var operation = ' '

    fun open() {

        mGameResult!!.error = null

        number1 = Random.nextInt(0, 20)
        number2 = Random.nextInt(0, 20)
        operation = arrayOf('-', '+', 'x').random()

        val newText = "$number1 $operation $number2 ="
        mGameText!!.text = newText

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
        mGameResult!!.text.clear()
        mGameResult!!.clearFocus()
        try {
            Handler(Looper.getMainLooper()).postDelayed({
                (context.getSystemService(Context.WINDOW_SERVICE) as WindowManager).removeView(mView)
                mView.invalidate()
            }, 500)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun doneButton() {
        if (result == "") {
            mGameResult!!.error = "Réponse vide"
        } else {
            try {
                var answer = 0
                when (operation) {
                    '-' -> answer = number1 - number2
                    '+' -> answer = number1 + number2
                    'x' -> answer = number1 * number2
                }
                if (result.toInt() == answer) {
                    close()
                } else {
                    mGameResult!!.error = "Mauvaise réponse"
                }
            } catch (e: Exception) {
                mGameResult!!.error = "La réponse doit être un nombre"
            }
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
        mGameText = mView.findViewById(R.id.game_text)

        mGameResult!!.doAfterTextChanged {
            result = mGameResult!!.text.toString()
            mGameResult!!.error = null
        }

        mGameValidate!!.setOnClickListener {
            doneButton()
        }
    }

}
