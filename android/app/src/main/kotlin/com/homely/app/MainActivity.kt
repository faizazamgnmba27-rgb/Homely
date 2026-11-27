package com.homely.app

import android.Manifest
import android.content.pm.PackageManager
import android.net.Uri
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val smsChannel = "com.homely.app/sms"
    private val smsPermissionCode = 1001
    private var pendingResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, smsChannel)
            .setMethodCallHandler { call, result ->
                if (call.method == "getInboxSms") {
                    if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_SMS)
                        == PackageManager.PERMISSION_GRANTED
                    ) {
                        result.success(readInboxSms())
                    } else {
                        pendingResult = result
                        ActivityCompat.requestPermissions(
                            this,
                            arrayOf(Manifest.permission.READ_SMS),
                            smsPermissionCode
                        )
                    }
                } else {
                    result.notImplemented()
                }
            }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == smsPermissionCode) {
            val res = pendingResult
            pendingResult = null
            if (res != null) {
                if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    res.success(readInboxSms())
                } else {
                    res.error("PERMISSION_DENIED", "SMS permission denied", null)
                }
            }
        }
    }

    private fun readInboxSms(): List<Map<String, Any>> {
        val smsList = mutableListOf<Map<String, Any>>()
        val uri = Uri.parse("content://sms/inbox")
        val projection = arrayOf("address", "body", "date")
        val cursor = contentResolver.query(uri, projection, null, null, "date DESC LIMIT 200")
        cursor?.use {
            val addrIdx = it.getColumnIndex("address")
            val bodyIdx = it.getColumnIndex("body")
            val dateIdx = it.getColumnIndex("date")
            while (it.moveToNext()) {
                val address = if (addrIdx >= 0) it.getString(addrIdx) ?: "" else ""
                val body = if (bodyIdx >= 0) it.getString(bodyIdx) ?: "" else ""
                val date = if (dateIdx >= 0) it.getLong(dateIdx) else 0L
                smsList.add(
                    mapOf(
                        "address" to address,
                        "body" to body,
                        "date" to date
                    )
                )
            }
        }
        return smsList
    }
}
