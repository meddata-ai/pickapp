package com.psgpw.pickapp.fragments

import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.net.toFile
import androidx.core.os.bundleOf
import androidx.fragment.app.Fragment
import androidx.fragment.app.setFragmentResult
import androidx.fragment.app.viewModels
import androidx.lifecycle.Observer
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import com.bumptech.glide.Glide
import com.psgpw.pickapp.HomeActivity
import com.psgpw.pickapp.LoginSignUpActivity
import com.psgpw.pickapp.R
import com.psgpw.pickapp.data.DataStoreManager
import com.psgpw.pickapp.databinding.FragmentSettingBinding
import com.psgpw.pickapp.domain.ResultState
import com.psgpw.pickapp.utils.showAlert
import com.psgpw.pickapp.utils.showTwoButtonAlert
import com.psgpw.pickapp.viewmodels.SettingViewModel
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch
import androidx.annotation.NonNull
import com.google.android.gms.auth.api.signin.GoogleSignIn
import com.google.android.gms.auth.api.signin.GoogleSignInClient

import com.google.android.gms.tasks.OnCompleteListener
import com.psgpw.pickapp.managers.GoogleLoginManager
import com.psgpw.pickapp.utils.showLogoutAlert


class SettingFragment : Fragment() {
    private lateinit var binding: FragmentSettingBinding
    private lateinit var getContent: ActivityResultLauncher<String>
    private val viewModel: SettingViewModel by viewModels<SettingViewModel>()

    private lateinit var apiKey: String
    private lateinit var userImage: String

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        binding = FragmentSettingBinding.inflate(inflater, container, false)
        chooseImageGallery()
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        setUpToolbar()

        lifecycleScope.launch {
            DataStoreManager(context!!).getUserApiKey().collect {
                apiKey = it
            }
        }
        lifecycleScope.launch {
            DataStoreManager(context!!).getUserImage().collect {
                userImage = it
                setImageToProfile(userImage)
            }
        }

        binding.rlAccount.setOnClickListener {
            findNavController().navigate(R.id.navigate_to_account_fragment)
        }

        binding.rlNotification.setOnClickListener {
            findNavController().navigate(R.id.navigate_to_notification_fragment)
        }

        binding.rlInviteFriends.setOnClickListener {
            val intent = Intent(Intent.ACTION_SEND)
            intent.type = "text/plain"
            intent.putExtra(
                Intent.EXTRA_TEXT,
                "https://play.google.com/store/apps/details?id=com.psgpw.pickapp"
            )
            startActivity(Intent.createChooser(intent, "Open with"))
        }

        binding.rlHelp.setOnClickListener {
            findNavController().navigate(R.id.navigate_to_help_center_fragment)
        }

        binding.ivProfile.setOnClickListener {
            // chooseImageGallery()
            getContent.launch("image/*")
        }

        binding.rlLogout.setOnClickListener {
            requireActivity().showLogoutAlert() { logout() }

        }
    }

    private fun logout() {
        lifecycleScope.launch {
            DataStoreManager(context!!).userLogout()
            signOutFromGoogle()
            requireActivity().finish()
            openLoginActivity()
        }
    }

    private fun openLoginActivity() {
        startActivity(
            Intent(
                requireActivity(),
                LoginSignUpActivity::class.java
            )
        )
    }

    private fun signOutFromGoogle() {
        val mGoogleSignInClient = GoogleLoginManager.getGoogleClient(requireActivity())
        mGoogleSignInClient.signOut().addOnCompleteListener(requireActivity(), OnCompleteListener {

        })
    }

    private fun setImageToProfile(url: String) {
        Glide.with(this).load(url).placeholder(R.drawable.ic_user_image).circleCrop()
            .into(binding.ivProfile)
    }

    private fun chooseImageGallery() {
        getContent = registerForActivityResult(ActivityResultContracts.GetContent()) {
            Glide.with(this).load(it).placeholder(R.drawable.ic_user_image).circleCrop()
                .into(binding.ivProfile)

            if (it != null) {
                val inputStream = requireActivity().contentResolver.openInputStream(it)
                viewModel.editUserImage(apiKey, inputStream!!.readBytes())
                viewModel.userImageState.observe(this, Observer {
                    when (it) {
                        is ResultState.Loading -> binding.progress.progressBar.visibility =
                            View.VISIBLE
                        is ResultState.Error -> {
                            binding.progress.progressBar.visibility = View.GONE
                            // Toast.makeText(context, it.exception.message, Toast.LENGTH_LONG).show()
                            requireActivity().showAlert(it.exception.message!!)
                        }
                        is ResultState.Success -> {
                            binding.progress.progressBar.visibility = View.GONE
                            requireActivity().showAlert("Your profile photo has been successfully changed!")
                            lifecycleScope.launch {
                                DataStoreManager(context!!).setUserImage(it.data.data.image)
                            }
                        }
                    }
                })
            }
        }


    }

    private fun setUpToolbar() {
        binding.toolbar.tvTitle.text = "Settings"
        binding.toolbar.ivUserProfile.visibility = View.GONE
        binding.toolbar.ivBack.setOnClickListener {
            findNavController().popBackStack()
        }
    }
}