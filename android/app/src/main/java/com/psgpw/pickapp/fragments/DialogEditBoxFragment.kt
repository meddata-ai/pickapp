package com.psgpw.pickapp.fragments

import android.os.Bundle
import android.text.InputType
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.core.os.bundleOf
import androidx.core.view.isNotEmpty
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.setFragmentResult
import androidx.fragment.app.viewModels
import androidx.lifecycle.lifecycleScope
import com.psgpw.pickapp.R
import com.psgpw.pickapp.data.DataStoreManager
import com.psgpw.pickapp.data.models.EditUserRequest
import com.psgpw.pickapp.data.models.SignInOrSignUpRequest
import com.psgpw.pickapp.data.network.KEY_EDIT_IMAGE
import com.psgpw.pickapp.data.network.KEY_EDIT_NAME
import com.psgpw.pickapp.data.network.KEY_EDIT_PHONE
import com.psgpw.pickapp.data.network.KEY_FORGOT_PASSWORD
import com.psgpw.pickapp.databinding.DialogEditProfileBinding
import com.psgpw.pickapp.databinding.DialogSingleEditboxBinding
import com.psgpw.pickapp.domain.ResultState
import com.psgpw.pickapp.utils.isValidEmail
import com.psgpw.pickapp.utils.showAlert
import com.psgpw.pickapp.viewmodels.SettingViewModel
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class DialogEditBoxFragment : DialogFragment() {
    private lateinit var binding: DialogEditProfileBinding
    private val settingViewModel: SettingViewModel by viewModels<SettingViewModel>()
    private lateinit var apiKey: String

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        binding = DialogEditProfileBinding.inflate(inflater, container, false)

        lifecycleScope.launch {
            DataStoreManager(context!!).getUserApiKey().collect {
                apiKey = it
            }
        }

        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        dialog?.window?.setBackgroundDrawableResource(android.R.color.transparent)
        binding.tvTitle.text = arguments?.getString("title")

        val apiType = arguments?.getString("key")

        when (apiType) {
            KEY_FORGOT_PASSWORD -> {
                binding.editText.isValidEmail("Required valid email")
            }
            KEY_EDIT_PHONE -> {
                binding.editText.inputType = InputType.TYPE_CLASS_PHONE
            }
        }

        binding.tvSave.setOnClickListener {
            if (binding.editText.text.toString().trim()
                    .isNotEmpty() && if (apiType.equals(KEY_FORGOT_PASSWORD)) binding.editText.text.toString()
                    .isValidEmail() else true
            ) {
                makeApiRequest(apiType)
            } else {
                Toast.makeText(context!!, "Please enter required field", Toast.LENGTH_SHORT).show()
            }
        }

        binding.tvCancel.setOnClickListener {
            dismiss()
        }
        binding.close.setOnClickListener {
            dismiss()
        }
    }

    private fun makeApiRequest(apiType: String?) {
        when (apiType) {
            KEY_FORGOT_PASSWORD -> createForgotPasswordRequest(apiType)
            KEY_EDIT_NAME -> createEditUserRequest(
                EditUserRequest(
                    key = apiType,
                    name = binding.editText.text.toString(),
                    apiKey = apiKey
                )
            )
            KEY_EDIT_PHONE -> createEditUserRequest(
                EditUserRequest(
                    key = apiType,
                    phone = binding.editText.text.toString(),
                    apiKey = apiKey
                )
            )
            //KEY_EDIT_IMAGE -> createEditUserRequest(EditUserRequest(key = apiType, name = binding.edtEditbox.getEditText().text.toString(), apiKey = apiKey))
        }
    }

    private fun createEditUserRequest(editUserRequest: EditUserRequest) {
        settingViewModel.editUser(editUserRequest)
        settingViewModel.settingState.observe(this, {
            when (it) {
                is ResultState.Loading -> binding.progress.progressBar.visibility = View.VISIBLE
                is ResultState.Error -> {
                    binding.progress.progressBar.visibility = View.GONE
                    Toast.makeText(context, it.exception.message, Toast.LENGTH_LONG).show()
                }
                is ResultState.Success -> {
                    binding.progress.progressBar.visibility = View.GONE
                    Toast.makeText(context, it.data.message, Toast.LENGTH_LONG).show()
                    lifecycleScope.launch {
                        val data = binding.editText.text.toString()
                        when (editUserRequest.key) {
                            KEY_EDIT_NAME -> {
                                DataStoreManager(context!!).setUserName(data)
                                // setFragmentResult(KEY_EDIT_NAME, bundleOf("data" to data))
                            }
                            KEY_EDIT_PHONE -> {
                                DataStoreManager(context!!).setUserPhone(data)
                                //setFragmentResult(KEY_EDIT_PHONE, bundleOf("data" to data))
                            }
                        }
                    }
                    dismiss()
                }

            }
        })
    }

    private fun createForgotPasswordRequest(apiType: String) {
        settingViewModel.forgotPassword(
            SignInOrSignUpRequest(
                key = apiType,
                email = binding.editText.text.toString()
            )
        )
        settingViewModel.forgotPasswordState.observe(this, {
            when (it) {
                is ResultState.Loading -> binding.progress.progressBar.visibility = View.VISIBLE
                is ResultState.Error -> {
                    binding.progress.progressBar.visibility = View.GONE
                    // Toast.makeText(context, it.exception.message, Toast.LENGTH_LONG).show()
                    requireActivity().showAlert(it.exception.message ?: "")
                }
                is ResultState.Success -> {
                    binding.progress.progressBar.visibility = View.GONE
                    // Toast.makeText(context, it.data.message, Toast.LENGTH_LONG).show()
                    requireActivity().showAlert(it.data.message)
                    dismiss()
                }

            }
        })
    }

}