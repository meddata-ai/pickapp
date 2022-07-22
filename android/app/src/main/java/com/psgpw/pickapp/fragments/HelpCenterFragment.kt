package com.psgpw.pickapp.fragments

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Binder
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.navigation.fragment.findNavController
import com.psgpw.pickapp.R
import com.psgpw.pickapp.databinding.FragmentHelpCenterBinding

class HelpCenterFragment : Fragment() {
    private lateinit var binding: FragmentHelpCenterBinding

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        binding = FragmentHelpCenterBinding.inflate(inflater, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setUpToolbar()
        binding.rlContactUs.setOnClickListener {
            findNavController().navigate(R.id.navigate_to_contact_us_fragment)
        }

        binding.rlPrivacyPolicy.setOnClickListener {
            val browserIntent = Intent(
                Intent.ACTION_VIEW
            )
            browserIntent.setData(
                Uri.parse("https://deckwebtech.com/pickapp_demo/Privacy-policy.html")
            )
            //  if (isActivityForIntentAvailable(requireContext(), browserIntent)) {
            val chooser = Intent.createChooser(browserIntent, "PickApp")
            chooser.flags = Intent.FLAG_ACTIVITY_NEW_TASK //
            startActivity(chooser)
            //}
        }
    }

    fun isActivityForIntentAvailable(context: Context, intent: Intent): Boolean {
        val packageManager: PackageManager = context.getPackageManager()
        val list: List<*> =
            packageManager.queryIntentActivities(intent, PackageManager.MATCH_DEFAULT_ONLY)
        return list.size > 0
    }

    private fun setUpToolbar() {
        binding.toolbar.tvTitle.text = "Help Center"
        binding.toolbar.ivUserProfile.setOnClickListener {
            // findNavController().navigate(R.id.action_navigate_to_settingFragment)
            findNavController().popBackStack()
        }

        binding.toolbar.ivBack.setOnClickListener {
            findNavController().popBackStack()
        }
    }
}