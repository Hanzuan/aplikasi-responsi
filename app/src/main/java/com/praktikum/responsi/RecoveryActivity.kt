package com.praktikum.responsi

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import kotlinx.android.synthetic.main.activity_recovery.*

class RecoveryActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_recovery)
        supportActionBar?.hide()


        btnBack2Listener()
        btnSendListener()
    }

    private fun btnBack2Listener(){
        H_back2.setOnClickListener {
            startActivity(Intent(this, MainActivity::class.java))
        }
    }

    private fun btnSendListener(){
        btn_send.setOnClickListener {
            startActivity(Intent(this, MainActivity::class.java))
        }
    }
}