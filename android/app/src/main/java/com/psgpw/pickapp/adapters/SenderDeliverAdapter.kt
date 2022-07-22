package com.psgpw.pickapp.adapters

import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.recyclerview.widget.RecyclerView
import android.widget.RelativeLayout
import android.view.ViewGroup
import android.view.LayoutInflater
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import androidx.core.content.ContextCompat.startActivity
import com.bumptech.glide.Glide
import com.psgpw.pickapp.R
import com.psgpw.pickapp.data.models.SenderOrDeliver

class SenderDeliverAdapter(
    val context: Context,
    var listener: ClickListener,
    var list: List<SenderOrDeliver>
) :
    RecyclerView.Adapter<SenderDeliverAdapter.ViewHolder>() {
    interface ClickListener {
        fun onItemClick(data: SenderOrDeliver?)
    }

    class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        var ivPhone: ImageView = view.findViewById(R.id.iv_phone)
        var rlCall: RelativeLayout = view.findViewById(R.id.rl_call)
        var tvPhoneNumber: TextView = view.findViewById(R.id.tv_phone_number)
        var ivProfile: ImageView = view.findViewById(R.id.iv_profile)
        var tvDepartureDate: TextView = view.findViewById(R.id.tv_departure_date)
        var tvFee: TextView = view.findViewById(R.id.tv_fee)
        var tvComment: TextView = view.findViewById(R.id.tv_comment)

        init {

            // Define click listener for the ViewHolder's View
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_sender_deliver, parent, false)
        return ViewHolder(view)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val item = list[position]
        holder.tvDepartureDate.text = "${item.departure}-${item.destination}. ${item.date}"
        holder.tvFee.text = "USD ${item.fee}$"
        holder.tvComment.text = "Comment: ${item.comment}"
        //holder.ivProfile.setImageURI()
        if (item.image != null && item.image.isNotEmpty()) {
            Glide.with(context).load(item.image).circleCrop()
                .into(holder.ivProfile)
        }

        holder.itemView.setOnClickListener {
            listener.onItemClick(item)
        }

        holder.ivPhone.setOnClickListener {
            if (holder.rlCall.visibility == View.VISIBLE) {
                holder.rlCall.visibility = View.GONE
            } else {
                holder.rlCall.visibility = View.VISIBLE
                holder.tvPhoneNumber.text = "Phone number: ${item.phone}"
                holder.tvPhoneNumber.setOnClickListener {
                    val dialIntent = Intent(Intent.ACTION_DIAL)
                    dialIntent.data = Uri.parse("tel:" + item.phone)
                    context.startActivity(dialIntent)
                }
            }
        }
    }

    override fun getItemCount(): Int {
        return list.size
    }
}