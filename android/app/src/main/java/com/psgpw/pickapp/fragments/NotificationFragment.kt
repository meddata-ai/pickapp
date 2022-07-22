package com.psgpw.pickapp.fragments

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import com.psgpw.pickapp.R
import com.psgpw.pickapp.data.DataStoreManager
import com.psgpw.pickapp.databinding.FragmentAccountBinding
import com.psgpw.pickapp.databinding.FragmentNotificationBinding
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

class NotificationFragment : Fragment() {

    private lateinit var binding: FragmentNotificationBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        binding = FragmentNotificationBinding.inflate(inflater, container, false)
        setUpToolbar()
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        lifecycleScope.launch {
            DataStoreManager(context!!).getNotificationAccountView().collect {
                binding.switchAccountView.isChecked = it
            }
        }

        lifecycleScope.launch {
            DataStoreManager(context!!).getNotificationContactView().collect {
                binding.switchContactNumber.isChecked = it
            }
        }

        lifecycleScope.launch {
            DataStoreManager(context!!).getNotificationSystemView().collect {
                binding.switchSystem.isChecked = it
            }
        }


        binding.switchAccountView.setOnCheckedChangeListener { buttonView, isChecked ->
            lifecycleScope.launch {
                DataStoreManager(requireContext()).setNotificationAccountView(
                    isChecked
                )
            }
        }


        binding.switchContactNumber.setOnCheckedChangeListener { buttonView, isChecked ->
            lifecycleScope.launch {
                DataStoreManager(requireContext()).setNotificationContactView(
                    isChecked
                )
            }
        }


        binding.switchSystem.setOnCheckedChangeListener { buttonView, isChecked ->
            lifecycleScope.launch {
                DataStoreManager(requireContext()).setNotificationSystemView(
                    isChecked
                )
            }
        }
    }

    private fun setUpToolbar() {
        binding.toolbar.tvTitle.text = "Notification"
        binding.toolbar.ivUserProfile.setOnClickListener {
            //  findNavController().navigate(R.id.action_navigate_to_settingFragment)
            findNavController().popBackStack()
        }

        binding.toolbar.ivBack.setOnClickListener {
            findNavController().popBackStack()
        }
    }
}