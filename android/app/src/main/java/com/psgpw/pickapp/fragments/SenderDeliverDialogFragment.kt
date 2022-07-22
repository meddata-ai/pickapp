package com.psgpw.pickapp.fragments

import android.view.LayoutInflater
import android.view.ViewGroup
import android.os.Bundle
import android.view.View
import androidx.fragment.app.DialogFragment
import com.bumptech.glide.Glide
import com.psgpw.pickapp.R
import com.psgpw.pickapp.data.models.SenderOrDeliver
import com.psgpw.pickapp.databinding.DialogSenderDeliverBinding
import com.psgpw.pickapp.databinding.FragmentSenderDeliverDialogBinding

class SenderDeliverDialogFragment : DialogFragment() {
    private lateinit var binding: DialogSenderDeliverBinding

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DialogSenderDeliverBinding.inflate(inflater, container, false)
        return binding.root
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        dialog?.window?.setBackgroundDrawableResource(android.R.color.transparent)
        val data: SenderOrDeliver? = arguments?.getParcelable<SenderOrDeliver>("data")
        binding.tvDeparture.text = "Departure: ${data?.departure}"
        binding.tvDestination.text = "Destination: ${data?.destination}"
        binding.tvFee.text = "Fee: USD ${data?.fee}$"
        binding.tvPhoneNumber.text = "Phone number: ${data?.phone}"
        binding.tvEmail.text = "E-mail: ${data?.email}"
        binding.tvComment.text = "Comment: ${data?.comment}"

        Glide.with(context!!).load(data?.image).placeholder(R.drawable.ic_user)
            .circleCrop()
            .into(binding.ivProfile)

        binding.btnClose.setOnClickListener {
            dismiss()
        }
    }
}