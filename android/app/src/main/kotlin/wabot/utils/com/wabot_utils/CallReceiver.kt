package wabot.utils.com.wabot_utils

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.telephony.PhoneStateListener
import android.telephony.TelephonyManager
import android.util.Log
import io.flutter.plugin.common.EventChannel

class CallReceiver : BroadcastReceiver() {
    private var eventSink: EventChannel.EventSink? = null

    fun setEventSink(eventSink: EventChannel.EventSink?) {
        this.eventSink = eventSink
    }

    fun cleanUp() {
        this.eventSink = null;
    }

    override fun onReceive(context: Context, intent: Intent) {
        println("ON CREATE LOG ON RECEIVE");

        if (intent.action == TelephonyManager.ACTION_PHONE_STATE_CHANGED) {
            val extras = intent.extras
            if (extras != null) {
                val state = extras.getString(TelephonyManager.EXTRA_STATE)
                val incomingNumber = extras.getString(TelephonyManager.EXTRA_INCOMING_NUMBER)

                // Send the call state and incoming number to Flutter
                val eventData = mapOf("state" to state, "number" to incomingNumber)
                eventSink?.success(eventData)
            }
        }
    }

//    override fun onReceive(context: Context, intent: Intent) {
//        val telephonyManager =
//            context.getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager
//        val phoneStateListener = object : PhoneStateListener() {
//            override fun onCallStateChanged(state: Int, phoneNumber: String?) {
//                if (state == TelephonyManager.CALL_STATE_RINGING && phoneNumber != null) {
//                    // Incoming call
//                    // Handle the phone number here
//                    Log.d("CallReceiverAlternative", "Incoming call from: $phoneNumber")
//
//                    // Example: Send the incoming phone number to Flutter
//                    val eventData = mapOf("state" to "RINGING", "number" to phoneNumber)
//                    eventSink?.success(eventData)
//                }
//            }
//        }
//        telephonyManager.listen(phoneStateListener, PhoneStateListener.LISTEN_CALL_STATE)
//    }
}