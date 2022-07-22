package com.psgpw.pickapp.fragments

import android.net.Uri
import android.os.Bundle
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.Toast
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.lifecycle.Observer
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import com.bumptech.glide.Glide
import com.psgpw.pickapp.R
import com.psgpw.pickapp.data.DataStoreManager
import com.psgpw.pickapp.data.models.UploadImagesRequest
import com.psgpw.pickapp.data.models.User
import com.psgpw.pickapp.data.network.ADD_POST_ID
import com.psgpw.pickapp.databinding.FragmentContactUsBinding
import com.psgpw.pickapp.domain.ResultState
import com.psgpw.pickapp.utils.showAlert
import com.psgpw.pickapp.utils.toPx
import com.psgpw.pickapp.viewmodels.SettingViewModel
import kotlinx.coroutines.flow.collect

class ContactUsFragment : Fragment() {
    private lateinit var binding: FragmentContactUsBinding
    private val viewModel: SettingViewModel by viewModels<SettingViewModel>()
    private lateinit var user: User

    private lateinit var getFile1: ActivityResultLauncher<String>
    private lateinit var getFile2: ActivityResultLauncher<String>
    private lateinit var getFile3: ActivityResultLauncher<String>

    private var file1: ByteArray? = null
    private var file2: ByteArray? = null
    private var file3: ByteArray? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        lifecycleScope.launchWhenCreated {
            DataStoreManager(context!!).getUserFromPreferencesStore().collect {
                user = it
            }
        }
        openGallary()
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        binding = FragmentContactUsBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setUpToolbar()

        binding.edtComment.getEditText().gravity = Gravity.START

        binding.tvNext.setOnClickListener {
            if (binding.edtComment.getEditText().text.isNotEmpty()) {
                createUploadRequest()
            } else {
                Toast.makeText(context, "Please enter your problem", Toast.LENGTH_SHORT).show()
            }
        }

        binding.ivFile1.setOnClickListener {
            getFile1.launch("image/*")
        }


        binding.ivFile2.setOnClickListener {
            getFile2.launch("image/*")
        }


        binding.ivFile3.setOnClickListener {
            getFile3.launch("image/*")
        }
    }

    private fun openGallary() {
        getFile1 = registerForActivityResult(ActivityResultContracts.GetContent()) {
            if (it != null) {
                binding.ivFile1.setPadding(0, 0, 0, 0)
                Glide.with(this).load(it).placeholder(R.drawable.ic_plus)
                    .into(binding.ivFile1)

                val inputStream = requireActivity().contentResolver.openInputStream(it)
                file1 = inputStream?.readBytes()
            }
        }

        getFile2 = registerForActivityResult(ActivityResultContracts.GetContent()) {
            if (it != null) {
                binding.ivFile1.setPadding(0, 0, 0, 0)
                Glide.with(this).load(it).placeholder(R.drawable.ic_plus)
                    .into(binding.ivFile2)

                val inputStream = requireActivity().contentResolver.openInputStream(it)
                file2 = inputStream?.readBytes()
            }
        }

        getFile3 = registerForActivityResult(ActivityResultContracts.GetContent()) {
            if (it != null) {
                binding.ivFile1.setPadding(0, 0, 0, 0)
                Glide.with(this).load(it).placeholder(R.drawable.ic_plus)
                    .into(binding.ivFile3)
                val inputStream = requireActivity().contentResolver.openInputStream(it)
                file3 = inputStream?.readBytes()
            }
        }
    }

    private fun createUploadRequest() {
        viewModel.uploadImages(
            UploadImagesRequest(
                ADD_POST_ID,
                comment = binding.edtComment.getEditText().text.toString(),
                phone = user.phone,
                email = user.email,
                uploadedFile1 = file1,
                uploadedFile2 = file2,
                uploadedFile3 = file3
            )
        )
        viewModel.settingState.observe(this, Observer {
            when (it) {
                is ResultState.Loading -> binding.progress.progressBar.visibility = View.VISIBLE
                is ResultState.Error -> {
                    binding.progress.progressBar.visibility = View.GONE
                    Toast.makeText(context, it.exception.message, Toast.LENGTH_LONG).show()
                }
                is ResultState.Success -> {
                    binding.progress.progressBar.visibility = View.GONE
                    // Toast.makeText(context, it.data.message, Toast.LENGTH_LONG).show()
                    requireActivity().showAlert("Your request has been successfully submitted!")
                    resetUI()
                }
            }
        })
    }

    private fun resetUI() {
        file1 = null
        file2 = null
        file3 = null
        binding.edtComment.getEditText().setText("")
        binding.ivFile1.setPadding(
            40.toPx.toInt(),
            40.toPx.toInt(),
            40.toPx.toInt(),
            40.toPx.toInt()
        )
        binding.ivFile1.setImageResource(R.drawable.ic_plus)
        binding.ivFile2.setPadding(
            40.toPx.toInt(),
            40.toPx.toInt(),
            40.toPx.toInt(),
            40.toPx.toInt()
        )
        binding.ivFile2.setImageResource(R.drawable.ic_plus)
        binding.ivFile3.setPadding(
            40.toPx.toInt(),
            40.toPx.toInt(),
            40.toPx.toInt(),
            40.toPx.toInt()
        )
        binding.ivFile3.setImageResource(R.drawable.ic_plus)
    }


    private fun setUpToolbar() {
        binding.toolbar.tvTitle.text = "Contact Us"
        binding.toolbar.ivUserProfile.setOnClickListener {
           findNavController().navigate(R.id.action_navigate_to_settingFragment)
        }

        binding.toolbar.ivBack.setOnClickListener {
            findNavController().popBackStack()
        }
    }
}