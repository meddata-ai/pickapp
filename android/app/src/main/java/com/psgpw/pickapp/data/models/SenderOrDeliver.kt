package com.psgpw.pickapp.data.models

import android.os.Parcel
import android.os.Parcelable

data class SenderOrDeliver(
    val id: String?,
    val departure: String?,
    val destination: String?,
    val date: String?,
    val fee: String?,
    val comment: String?,
    val phone: String?,
    val email: String?,
    val apikey: String?,
    val image: String?,

    ) : Parcelable {
    constructor(parcel: Parcel) : this(
        parcel.readString(),
        parcel.readString(),
        parcel.readString(),
        parcel.readString(),
        parcel.readString(),
        parcel.readString(),
        parcel.readString(),
        parcel.readString(),
        parcel.readString(),
        parcel.readString()
    ) {
    }

    override fun describeContents(): Int {
        TODO("Not yet implemented")
    }

    override fun writeToParcel(dest: Parcel?, flags: Int) {
        TODO("Not yet implemented")
    }

    companion object CREATOR : Parcelable.Creator<SenderOrDeliver> {
        override fun createFromParcel(parcel: Parcel): SenderOrDeliver {
            return SenderOrDeliver(parcel)
        }

        override fun newArray(size: Int): Array<SenderOrDeliver?> {
            return arrayOfNulls(size)
        }
    }
}