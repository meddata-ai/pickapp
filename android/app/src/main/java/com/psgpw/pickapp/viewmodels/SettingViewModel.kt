package com.psgpw.pickapp.viewmodels

import android.net.Uri
import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.asLiveData
import androidx.lifecycle.viewModelScope
import com.psgpw.pickapp.data.DataStoreManager
import com.psgpw.pickapp.data.models.BaseRequest
import com.psgpw.pickapp.data.models.UploadImagesRequest
import com.psgpw.pickapp.data.models.User
import com.psgpw.pickapp.data.repos.NetworkRepo
import com.psgpw.pickapp.domain.ResponseData
import com.psgpw.pickapp.domain.ResultState
import hilt_aggregated_deps._dagger_hilt_android_internal_modules_ApplicationContextModule
import kotlinx.coroutines.launch

class SettingViewModel : ViewModel() {

    private val networkRepo = NetworkRepo()

    lateinit var settingState: LiveData<ResultState<ResponseData<Nothing>>>

    lateinit var userImageState: LiveData<ResultState<ResponseData<User>>>

    lateinit var forgotPasswordState: LiveData<ResultState<ResponseData<User>>>

    fun editUser(baseRequest: BaseRequest) {
        viewModelScope.launch {
            settingState = networkRepo.editUser(baseRequest).asLiveData()
        }
    }

    fun editUserImage(apiKey: String, file: ByteArray) {
        viewModelScope.launch {
            userImageState = networkRepo.editUserImage(apiKey, file = file).asLiveData()
        }
    }

    fun uploadImages(uploadImagesRequest: UploadImagesRequest) {
        viewModelScope.launch {
            settingState = networkRepo.uploadImages(uploadImagesRequest).asLiveData()
        }
    }


    fun forgotPassword(baseRequest: BaseRequest) {
        viewModelScope.launch {
            forgotPasswordState = networkRepo.getSignInUser(baseRequest).asLiveData()
        }
    }


}