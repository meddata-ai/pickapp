package com.psgpw.pickapp.viewmodels

import androidx.lifecycle.*
import com.psgpw.pickapp.data.models.BaseRequest
import com.psgpw.pickapp.data.repos.NetworkRepo
import com.psgpw.pickapp.domain.ResponseData
import com.psgpw.pickapp.domain.ResultState
import kotlinx.coroutines.launch

class AddSenderOrDeliverViewModel : ViewModel() {

    private val networkRepo = NetworkRepo()

    var dataState: LiveData<ResultState<ResponseData<Any>>> = MutableLiveData<ResultState<ResponseData<Any>>>()

    fun addSenderOrDeliver(baseRequest: BaseRequest) {
        viewModelScope.launch {
            dataState = networkRepo.addSenderOrDeliver(baseRequest).asLiveData()
        }
    }
}