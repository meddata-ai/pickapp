package com.psgpw.pickapp.fragments

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import com.psgpw.pickapp.R
import com.psgpw.pickapp.data.DataStoreManager
import com.psgpw.pickapp.data.models.User
import com.psgpw.pickapp.data.network.KEY_EDIT_NAME
import com.psgpw.pickapp.data.network.KEY_EDIT_PHONE
import com.psgpw.pickapp.data.network.KEY_FORGOT_PASSWORD
import com.psgpw.pickapp.databinding.FragmentAccountBinding
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class AccountFragment : Fragment() {

    private lateinit var binding: FragmentAccountBinding
    private lateinit var user: User

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        binding = FragmentAccountBinding.inflate(inflater, container, false)

        lifecycleScope.launch {
            DataStoreManager(context!!).getUserFromPreferencesStore().collect {
                user = it
                binding.tvName.text = user.name
                binding.tvPhoneNumber.text = user.phone
                binding.tvEmail.text = user.email
            }
        }
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        setUpToolbar()

        binding.ivEditName.setOnClickListener {
            openEditBoxDialog("Enter your name", KEY_EDIT_NAME)
        }

        binding.ivEditNumber.setOnClickListener {
            openEditBoxDialog("Enter your number", KEY_EDIT_PHONE)
        }

//        parentFragmentManager.setFragmentResultListener(KEY_EDIT_NAME, this) { requestKey, bundle ->
//            when (requestKey) {
//
//            }
//        }
    }


    private fun setUpToolbar() {
        binding.toolbar.tvTitle.text = "Account"
        binding.toolbar.ivUserProfile.setOnClickListener {
          //  findNavController().navigate(R.id.action_navigate_to_settingFragment)
            findNavController().popBackStack()
        }

        binding.toolbar.ivBack.setOnClickListener {
            findNavController().popBackStack()
        }
    }

    private fun openEditBoxDialog(title: String, key: String) {
        val bundle = Bundle().apply {
            putString("title", title)
            putString("key", key)
        }
        val fragment = DialogEditBoxFragment().apply { arguments = bundle }
        fragment.show(parentFragmentManager, "EditBox Dialog")

    }
}