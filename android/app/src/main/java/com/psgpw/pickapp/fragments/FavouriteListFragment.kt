package com.psgpw.pickapp.fragments

import android.view.LayoutInflater
import android.view.ViewGroup
import android.os.Bundle
import android.view.View
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import com.psgpw.pickapp.R
import com.psgpw.pickapp.databinding.FragmentFavouriteListBinding

class FavouriteListFragment : Fragment() {
    private lateinit var binding: FragmentFavouriteListBinding

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?, savedInstanceState: Bundle?
    ): View? {
        binding = FragmentFavouriteListBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setUpToolbar()
    }


    private fun setUpToolbar() {
        binding.toolbar.tvTitle.text = "Favorite List"
        binding.toolbar.ivUserProfile.setOnClickListener {
            findNavController().navigate(R.id.action_navigate_to_settingFragment)
        }
        binding.toolbar.ivBack.setOnClickListener {
            findNavController().popBackStack()
        }
    }

}