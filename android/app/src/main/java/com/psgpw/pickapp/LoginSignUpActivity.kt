package com.psgpw.pickapp

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.content.Intent
import android.util.Log
import android.view.View
import android.widget.Toast
import androidx.activity.viewModels
import androidx.core.os.bundleOf
import androidx.lifecycle.Observer
import androidx.lifecycle.lifecycleScope
import com.psgpw.pickapp.data.DataStoreManager
import com.psgpw.pickapp.data.models.SignInOrSignUpRequest
import com.psgpw.pickapp.data.models.User
import com.psgpw.pickapp.data.network.KEY_FORGOT_PASSWORD
import com.psgpw.pickapp.data.network.REGISTRATION_KEY
import com.psgpw.pickapp.data.network.SIGN_IN_KEY
import com.psgpw.pickapp.databinding.ActivityLoginSignUpactivityBinding
import com.psgpw.pickapp.domain.ResponseData
import com.psgpw.pickapp.domain.ResultState
import com.psgpw.pickapp.fragments.DialogEditBoxFragment
import com.psgpw.pickapp.utils.*
import com.psgpw.pickapp.viewmodels.LoginSignUpViewModel
import kotlinx.coroutines.*
import com.google.android.gms.common.api.ApiException
import com.google.android.gms.auth.api.signin.GoogleSignIn
import com.facebook.*
import com.facebook.login.LoginManager
import com.facebook.login.LoginResult
import com.google.android.gms.auth.api.signin.GoogleSignInClient
import com.google.android.gms.auth.api.signin.GoogleSignInAccount
import com.google.android.gms.tasks.Task
import com.psgpw.pickapp.data.network.KEY_SOCIAL_LOGIN
import com.psgpw.pickapp.managers.GoogleLoginManager
import org.json.JSONObject


class LoginSignUpActivity : AppCompatActivity() {
    val viewModel: LoginSignUpViewModel by viewModels<LoginSignUpViewModel>()

    private lateinit var binding: ActivityLoginSignUpactivityBinding
    private lateinit var mGoogleSignInClient: GoogleSignInClient

    private var account: GoogleSignInAccount? = null

    val callbackManager = CallbackManager.Factory.create();

    private fun signIn() {
        val signInIntent: Intent = mGoogleSignInClient.getSignInIntent()
        startActivityForResult(signInIntent, 100)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        callbackManager.onActivityResult(requestCode, resultCode, data);
        super.onActivityResult(requestCode, resultCode, data)

        // Result returned from launching the Intent from GoogleSignInClient.getSignInIntent(...);
        if (requestCode == 100) {
            // The Task returned from this call is always completed, no need to attach
            // a listener.
            val task: Task<GoogleSignInAccount> = GoogleSignIn.getSignedInAccountFromIntent(data)
            handleSignInResult(task)
        }
    }

    private fun handleSignInResult(completedTask: Task<GoogleSignInAccount>) {
        try {
            account = completedTask.getResult(ApiException::class.java)
            Log.d("Login Activity : Name", account!!.displayName.toString())
            Log.d("Login Activity : Email", account!!.email.toString())
            callSocialLoginApi(
                name = account!!.displayName.toString(),
                email = account!!.email.toString()
            )
            apiLoginSignUpObserver()
        } catch (e: ApiException) {
            Log.w("LoginActivity", "signInResult:failed code=" + e.statusCode)
            Toast.makeText(this, "signInResult:failed code=\"" + e.statusCode, Toast.LENGTH_LONG)
                .show()
        }
    }

    private fun callSocialLoginApi(name: String, email: String) {
        viewModel.signInSignUpUser(
            SignInOrSignUpRequest(
                KEY_SOCIAL_LOGIN, name = name, email = email
            )
        )
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        mGoogleSignInClient = GoogleLoginManager.getGoogleClient(this)

        account = GoogleLoginManager.getLastLoginAccount(this)

        binding = ActivityLoginSignUpactivityBinding.inflate(layoutInflater)


        binding.toolbar.ivUserProfile.visibility = View.GONE

        binding.tvGoogle.setOnClickListener {
            signIn()
        }

        binding.tvFacebook.setOnClickListener {
            LoginManager.getInstance()
                .logInWithReadPermissions(this, arrayListOf("public_profile", "email"))

        }
        LoginManager.getInstance()
            .registerCallback(callbackManager, object : FacebookCallback<LoginResult> {
                override fun onCancel() {
                    Toast.makeText(
                        this@LoginSignUpActivity,
                        "facebook Login Canceled",
                        Toast.LENGTH_SHORT
                    ).show()
                }

                override fun onError(error: FacebookException) {
                    Toast.makeText(this@LoginSignUpActivity, "Error in login", Toast.LENGTH_SHORT)
                        .show()
                }

                override fun onSuccess(result: LoginResult) {
                    Profile.getCurrentProfile()?.firstName?.let { Log.d("LoginActivity", it) }
                    getProfileFromFacebook(result!!)
                }
            })

        val accessToken = AccessToken.getCurrentAccessToken();
        val isLoggedIn = accessToken != null && !accessToken.isExpired;


        binding.edtEmail.getEditText().isValidEmail("Valid Email address required")

        binding.edtName.getEditText().isValidName("Name should be at least 3 character")

        binding.edtPassword.getEditText().isValidPassword("Password must contain 3 character")

        binding.edtConfirmPassword.getEditText().isValidConfirmPassword(
            "Must be same as password",
            binding.edtPassword.getEditText()
        )

        binding.tvForgotPassword.setOnClickListener {
            forgetPasswordClick()
        }

        clickEntranceButton()

        binding.tvEntrance.setOnClickListener {
            clickEntranceButton()
        }

        binding.tvRegistraion.setOnClickListener {
            clickRegistrationButton()
        }
        binding.edtPassword.showHideText()
        binding.edtConfirmPassword.showHideText()

        binding.tvSubmit.setOnClickListener {
            if (binding.tvEntrance.isSelected && isLoginValidationSuccess()) {
                viewModel.signInSignUpUser(loginRequest())
                apiLoginSignUpObserver()
            } else if (binding.tvRegistraion.isSelected && isRegistrationValidationSuccess()) {
                viewModel.registerUser(registrationRequest())
                apiLoginSignUpObserver()
            }
        }

        setContentView(binding.root)
    }

    private fun getProfileFromFacebook(loginResult: LoginResult) {
        val request = GraphRequest.newMeRequest(
            loginResult.accessToken,
            GraphRequest.GraphJSONObjectCallback { json, response ->
                if (response!!.error != null) {
                    Toast.makeText(this, "Error in login", Toast.LENGTH_SHORT).show()
                } else {
                    val fbUserEmail: String = json!!.optString("email")

                    Profile.getCurrentProfile()?.name?.let { callSocialLoginApi(it, fbUserEmail) }
                    apiLoginSignUpObserver()

                }
            })
        request.parameters = bundleOf(Pair("fields", "email"))
        request.executeAsync()
    }

    private fun forgetPasswordClick() {
        val bundle = Bundle().apply {
            putString("title", "Enter Email")
            putString("key", KEY_FORGOT_PASSWORD)
        }
        val fragment = DialogEditBoxFragment().apply { arguments = bundle }
        fragment.show(supportFragmentManager, "EditBox Dialog")
    }

    private fun apiLoginSignUpObserver() {
        viewModel.loginState.observe(this, Observer<ResultState<ResponseData<User>>> {
            when (it) {
                is ResultState.Loading -> binding.progress.progressBar.visibility = View.VISIBLE
                is ResultState.Error -> {
                    binding.progress.progressBar.visibility = View.GONE
                    Toast.makeText(this, it.exception.message, Toast.LENGTH_SHORT).show()
                }
                is ResultState.Success -> {
                    binding.progress.progressBar.visibility = View.GONE
                    Toast.makeText(this, it.data.message, Toast.LENGTH_SHORT).show()
                    Log.d("Login Data", it.data.toString())
                    lifecycleScope.launch {
                        DataStoreManager(context = applicationContext).saveUserToPreferencesStore(it.data.data)
                    }
                    navigateToHomeActivity()
                }
            }
        })
    }

    private fun registrationRequest(): SignInOrSignUpRequest {
        return SignInOrSignUpRequest(
            REGISTRATION_KEY,
            name = binding.edtName.getEditText().text.toString(),
            email = binding.edtEmail.getEditText().text.toString(),
            password = binding.edtPassword.getEditText().text.toString(),
            confirmPassword = binding.edtConfirmPassword.getEditText().text.toString()
        )
    }

    private fun loginRequest(): SignInOrSignUpRequest {
        return SignInOrSignUpRequest(
            SIGN_IN_KEY,
            email = binding.edtEmail.getEditText().text.toString(),
            password = binding.edtPassword.getEditText().text.toString()
        )
    }

    private fun isLoginValidationSuccess(): Boolean {
        return binding.edtEmail.getEditText().text.toString().isValidEmail() &&
                binding.edtPassword.getEditText().text.toString().isValidPassword()
    }

    private fun isRegistrationValidationSuccess(): Boolean {
        return binding.edtName.getEditText().text.toString().isValidName() &&
                binding.edtEmail.getEditText().text.toString().isValidEmail() &&
                binding.edtPassword.getEditText().text.toString().isValidPassword() &&
                binding.edtConfirmPassword.getEditText().text.toString()
                    .isValidConfirmPassword(binding.edtPassword.getEditText().text.toString())
    }

    private fun clickRegistrationButton() {
        with(binding) {
            tvRegistraion.isSelected = true
            tvEntrance.isSelected = false
            edtName.visibility = View.VISIBLE
            edtConfirmPassword.visibility = View.VISIBLE
            tvForgotPassword.visibility = View.GONE
            tvSignInText.text = "Create an account. Registration"
        }
    }

    private fun clickEntranceButton() {
        with(binding) {
            tvRegistraion.isSelected = false
            tvEntrance.isSelected = true
            edtName.visibility = View.GONE
            edtConfirmPassword.visibility = View.GONE
            tvForgotPassword.visibility = View.VISIBLE
            tvSignInText.text = "Or sign in with"
        }
    }

    private fun navigateToHomeActivity() {
        startActivity(
            Intent(
                this@LoginSignUpActivity,
                HomeActivity::class.java
            )
        )
        finish()
    }
}
