import android.annotation.SuppressLint
import android.content.Context
import android.util.Log
import androidx.core.content.ContextCompat
import com.andrognito.pinlockview.IndicatorDots
import com.andrognito.pinlockview.PinLockListener
import com.andrognito.pinlockview.PinLockView
import com.applockFlutter.R


class PinCodeActivity(
        private val context: Context
) {

    var pinCode: String = ""

    private var mPinLockView: PinLockView? = null

    private var mIndicatorDots: IndicatorDots? = null
    private val mPinLockListener: PinLockListener = object : PinLockListener {
        @SuppressLint("LogConditional")
        override fun onComplete(pin: String) {
            Log.d(TAG, "Pin complete: $pin")
            pinCode = pin
        }

        override fun onEmpty() {
            Log.d(TAG, "Pin empty")
            pinCode = ""
        }

        @SuppressLint("LogConditional")
        override fun onPinChange(pinLength: Int, intermediatePin: String) {
            pinCode = intermediatePin
            Log.d(
                TAG,
                "Pin changed, new length $pinLength with intermediate pin $intermediatePin"
            )
        }
    }

    init {
        try{

            mPinLockView!!.attachIndicatorDots(mIndicatorDots)
            mPinLockView!!.setPinLockListener(mPinLockListener)
            println("Pincode class Activated--2")

            mPinLockView!!.pinLength = 6
            mPinLockView!!.textColor = ContextCompat.getColor(context, R.color.ic_launcher_background)
            mIndicatorDots!!.indicatorType = IndicatorDots.IndicatorType.FILL_WITH_ANIMATION

        } catch (e: Exception) {
            e.printStackTrace()
        }
    }


    companion object {
        const val TAG = "PinLockView"
    }
}
