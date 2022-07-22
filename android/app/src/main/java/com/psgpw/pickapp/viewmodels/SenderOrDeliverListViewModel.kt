package com.psgpw.pickapp.viewmodels

import androidx.lifecycle.*
import com.psgpw.pickapp.data.models.BaseRequest
import com.psgpw.pickapp.data.models.SenderOrDeliver
import com.psgpw.pickapp.data.repos.NetworkRepo
import com.psgpw.pickapp.domain.ResponseData
import com.psgpw.pickapp.domain.ResultState
import kotlinx.coroutines.launch

class SenderOrDeliverListViewModel : ViewModel() {
    private val networkRepo = NetworkRepo()

    var dataState: LiveData<ResultState<ResponseData<List<SenderOrDeliver>>>> = MutableLiveData<ResultState<ResponseData<List<SenderOrDeliver>>>>()

    fun getSenderOrDeliver(baseRequest: BaseRequest) {
        viewModelScope.launch {
            dataState = networkRepo.getSenderOrDeliverList(baseRequest).asLiveData()
        }
    }

}