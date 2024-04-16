import android.content.Context
import android.graphics.PixelFormat
import android.os.Handler
import android.os.Looper
import android.view.*
import androidx.fragment.app.FragmentActivity
import com.applockFlutter.R
import io.flutter.embedding.android.FlutterFragment
import android.app.ActivityManager;

class Window(private val context: Context) {
    private val mView: View
    private var mParams: WindowManager.LayoutParams? = null
    private val mWindowManager: WindowManager
    private val layoutInflater: LayoutInflater

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
        return mView.windowToken != null && mView.parent != null
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
        mView = layoutInflater.inflate(R.layout.pin_activity, null)

        mParams!!.gravity = Gravity.CENTER
        mWindowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager

        val flutterFragment = FlutterFragment.createDefault()

       // val fragmentManager = (context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager).runningAppProcesses
        //    .find { it.processName == service.packageName }?.importance

        val transaction = (context as FragmentActivity).supportFragmentManager.beginTransaction()
        transaction.replace(R.id.flutter_game_fragment, flutterFragment).commit()
    }
}