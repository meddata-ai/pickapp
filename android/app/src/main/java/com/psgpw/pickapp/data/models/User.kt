package com.psgpw.pickapp.data.models

import java.lang.NullPointerException

data class User(
    val id :String,
    val apikey :String? = null,
    val name :String,
    val phone :String? = null,
    val email :String,
    val image :String,
    val verified :String? = null,
) {
}