package com.praktikum.responsi

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import kotlinx.android.synthetic.main.activity_register.*

class RegisterActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_register)
        supportActionBar?.hide()

        btnBackListener()
        btnRegisterListener()
        txtLoginListener()
    }

    private fun btnBackListener(){
        H_back.setOnClickListener{
            startActivity(Intent(this, MainActivity::class.java))
        }
    }

    private fun btnRegisterListener(){
        btn_rgst.setOnClickListener {
            startActivity(Intent(this, HomeActivity::class.java))
        }
    }

    private fun txtLoginListener(){
        txt_login.setOnClickListener {
            startActivity(Intent(this, MainActivity::class.java))
        }
    }
}