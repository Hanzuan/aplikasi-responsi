package com.praktikum.responsi

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        supportActionBar?.hide()

        txtLoginListener()
        btnLoginListener()
        txtRegisterListener()
    }

    private fun txtLoginListener(){
        txt_lgn.setOnClickListener {
            startActivity(Intent(this,RecoveryActivity::class.java))
        }
    }

    private fun btnLoginListener(){
        btn_login.setOnClickListener {
            startActivity(Intent(this, HomeActivity::class.java))
        }
    }

    private fun txtRegisterListener(){
        txt_rgstr.setOnClickListener {
            startActivity(Intent(this, RegisterActivity::class.java))
        }
    }
}