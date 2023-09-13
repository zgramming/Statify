package wabot.utils.com.wabot_utils

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.provider.Telephony
import android.util.Log
import io.flutter.plugin.common.EventChannel

class DeliveredSMSReceiver : BroadcastReceiver(), EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    override fun onReceive(context: Context?, intent: Intent?) {
        // Check if the intent is null

        val bundle = intent?.extras
        val message = bundle?.getString("message") ?: ""
        val code = bundle?.getInt("code") ?: 0
        val status = bundle?.getString("status") ?: ""

        val map = mapOf(
            "message" to message,
            "code" to code,
            "status" to status
        )

        Log.wtf("DeliveredSMSReceiver.kt", "Called with $map");

        eventSink?.success(map)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}