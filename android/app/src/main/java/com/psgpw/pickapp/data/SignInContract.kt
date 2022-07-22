package com.psgpw.pickapp.data

import com.psgpw.pickapp.data.models.User

interface SignInContract {
    fun signIn() : User
}
