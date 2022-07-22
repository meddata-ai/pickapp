package com.psgpw.pickapp.fragments

import android.content.Intent
import android.view.LayoutInflater
import android.view.ViewGroup
import android.os.Bundle
import android.view.View
import android.widget.ImageView
import androidx.appcompat.widget.Toolbar
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import com.psgpw.pickapp.R
import com.psgpw.pickapp.SendOrDeliverActivity
import com.psgpw.pickapp.data.network.ADD_DELIVER_ID
import com.psgpw.pickapp.data.network.ADD_SENDER_ID

import com.psgpw.pickapp.databinding.FragmentDashboardBinding

class DashboardFragment : Fragment() {
    private lateinit var binding: FragmentDashboardBinding
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?, savedInstanceState: Bundle?
    ): View? {
        binding = FragmentDashboardBinding.inflate(inflater, container, false)

        binding.llSendRequest.setOnClickListener {
            openSenderOrDeliverActivity(ADD_SENDER_ID)
        }

        binding.llDeliverRequest.setOnClickListener {
            openSenderOrDeliverActivity(ADD_DELIVER_ID)
        }

        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        binding.toolbar.ivUserProfile.setOnClickListener { view ->
            findNavController().navigate(R.id.action_navigate_to_settingFragment)
        }
    }
    private fun openSenderOrDeliverActivity(requestType: String) {
        val intent = Intent(context, SendOrDeliverActivity::class.java)
        intent.putExtra("request_type", requestType)
        startActivity(intent)
    }
}