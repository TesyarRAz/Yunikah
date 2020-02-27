package com.kosim.yunikah.ui.login

import android.app.Activity
import android.app.ProgressDialog
import android.content.Context
import android.content.SharedPreferences
import androidx.lifecycle.ViewModelProviders
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.view.inputmethod.EditorInfo
import android.widget.*
import com.kosim.yunikah.Global

import com.kosim.yunikah.R
import com.kosim.yunikah.model.User
import com.kosim.yunikah.network.ApiNetwork
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class LoginActivity : AppCompatActivity() {

    private lateinit var loginViewModel: LoginViewModel
    private lateinit var progressDialog: ProgressDialog

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_login)
        supportActionBar?.hide()

        val username = findViewById<EditText>(R.id.username)
        val password = findViewById<EditText>(R.id.password)
        val login = findViewById<Button>(R.id.login)

        loginViewModel = ViewModelProviders.of(this).get(LoginViewModel::class.java)
        progressDialog = ProgressDialog(this)

        progressDialog.apply {
            setMessage("Sedang Meloading...")
            setCancelable(false)
        }

        login.apply {
            setOnEditorActionListener(TextView.OnEditorActionListener { _, actionId, _ ->
                when (actionId) {
                    EditorInfo.IME_ACTION_DONE ->
                        login(username.toString(), password.toString())
                }
                false
            })
        }
    }

    fun login(username: String, password: String) : Boolean {
        progressDialog.show()

        ApiNetwork.getApiInterface().actionLogin(username, password).enqueue(
            object : Callback<User> {
                override fun onFailure(call: Call<User>, t: Throwable) {
                    progressDialog.hide()

                    Toast.makeText(applicationContext, t.message, Toast.LENGTH_LONG).show()
                }

                override fun onResponse(call: Call<User>, response: Response<User>) {
                    progressDialog.hide()

                    val user = response.body()

                    if (response.code() != 200) {
                        Toast.makeText(applicationContext, user?.error, Toast.LENGTH_LONG).show()

                        return;
                    }

                    user?.let {
                        Global.user = it

                        // Todo Save User
                        val preferences = getPreferences(Context.MODE_PRIVATE)
                        preferences.edit().apply {
                            putString("auth-token", it.token)
                            apply()
                        }
                        // End

                        setResult(Activity.RESULT_OK)
                        finish()
                    }

                }
            }
        )

        return true
    }
}