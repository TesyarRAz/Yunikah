package com.kosim.yunikah;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;

public class RegisterActivity extends AppCompatActivity {

    private Button btn_register;
    private EditText nama,notelp,alamat,username,password;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        btn_register = findViewById(R.id.btn_register);
        nama = findViewById(R.id.txt_nama);
        notelp= findViewById(R.id.txt_notelp);
        username = findViewById(R.id.txt_username);
        alamat = findViewById(R.id.txt_alamat);
        password = findViewById(R.id.txt_password);


    }
}
