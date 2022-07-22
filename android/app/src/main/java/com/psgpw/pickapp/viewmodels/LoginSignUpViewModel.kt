package com.psgpw.pickapp.viewmodels

import androidx.lifecycle.*
import com.psgpw.pickapp.data.models.BaseRequest
import com.psgpw.pickapp.data.models.User
import com.psgpw.pickapp.data.repos.NetworkRepo
import com.psgpw.pickapp.domain.ResponseData
import com.psgpw.pickapp.domain.ResultState
import kotlinx.coroutines.launch
import kotlin.coroutines.Continuation
import kotlin.coroutines.suspendCoroutine

class LoginSignUpViewModel() : ViewModel() {

    private val networkRepo = NetworkRepo()

    lateinit var loginState: LiveData<ResultState<ResponseData<User>>>

    fun signInSignUpUser(baseRequest: BaseRequest) {
        viewModelScope.launch {
            loginState = networkRepo.getSignInUser(baseRequest).asLiveData()

        }
    }


    fun registerUser(baseRequest: BaseRequest) {
        viewModelScope.launch {
            loginState = networkRepo.registerUser(baseRequest).asLiveData()
        }
    }

}