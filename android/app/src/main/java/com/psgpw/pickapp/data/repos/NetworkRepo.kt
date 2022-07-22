package com.psgpw.pickapp.data.repos

import android.app.Application
import android.net.Uri
import com.psgpw.pickapp.data.models.BaseRequest
import com.psgpw.pickapp.data.models.SenderOrDeliver
import com.psgpw.pickapp.data.models.UploadImagesRequest
import com.psgpw.pickapp.data.models.User
import com.psgpw.pickapp.data.network.ApiHelper
import com.psgpw.pickapp.domain.ResponseData
import com.psgpw.pickapp.domain.ResultState
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.withContext
import java.lang.Exception
import java.lang.IllegalStateException
import kotlin.coroutines.Continuation

class NetworkRepo {

    suspend fun getSignInUser(
        baseRequest: BaseRequest
    ): Flow<ResultState<ResponseData<User>>> = flow {
        try {
            emit(ResultState.Loading)
            val responseData = ApiHelper.getSignInUser(baseRequest)
            if (responseData.status) {
                emit(ResultState.Success(responseData))

            } else {
                emit(ResultState.Error(Exception(responseData.message)))
            }
        } catch (ex: Exception) {
            emit(ResultState.Error(ex))
        }

    }.flowOn(Dispatchers.IO)


    suspend fun registerUser(
        baseRequest: BaseRequest
    ): Flow<ResultState<ResponseData<User>>> = flow {
        try {
            emit(ResultState.Loading)
            val responseData = ApiHelper.registerUser(baseRequest)
            if (responseData.status) {
                emit(ResultState.Success(responseData))
            } else {
                emit(ResultState.Error(Exception(responseData.message)))
            }
        } catch (ex: Exception) {
            emit(ResultState.Error(ex))
        }
    }.flowOn(Dispatchers.IO)


    suspend fun editUser(
        baseRequest: BaseRequest
    ): Flow<ResultState<ResponseData<Nothing>>> = flow {
        try {
            emit(ResultState.Loading)
            val responseData = ApiHelper.editUser(baseRequest)
            if (responseData.status) {
                emit(ResultState.Success(responseData))
            } else {
                emit(ResultState.Error(Exception(responseData.message)))
            }
        } catch (ex: Exception) {
            emit(ResultState.Error(ex))
        }
    }.flowOn(Dispatchers.IO)

    suspend fun editUserImage(
        apiKey: String, file: ByteArray
    ): Flow<ResultState<ResponseData<User>>> = flow {
        //try {
            emit(ResultState.Loading)
            val responseData = ApiHelper.editUserImage(apiKey = apiKey, uri = file)
            if (responseData.status) {
                emit(ResultState.Success(responseData))
            } else {
                emit(ResultState.Error(Exception(responseData.message)))
            }
      //  } catch (ex: Exception) {
        //    emit(ResultState.Error(ex))
        //}
    }.flowOn(Dispatchers.IO)
        .catch { e ->
            emit(ResultState.Error(Exception(e.message)))
        }


    suspend fun getSenderOrDeliverList(
        baseRequest: BaseRequest
    ): Flow<ResultState<ResponseData<List<SenderOrDeliver>>>> = flow {
        try {
            emit(ResultState.Loading)
            val responseData = ApiHelper.getSenderOrDeliver(baseRequest)
            if (responseData.status) {
                emit(ResultState.Success(responseData))
            } else {
                emit(ResultState.Error(Exception(responseData.message)))
            }
        } catch (ex: Exception) {
            emit(ResultState.Error(ex))
        }
    }.flowOn(Dispatchers.IO)
        .debounce(300)

    suspend fun uploadImages(
        uploadImagesRequest: UploadImagesRequest
    ): Flow<ResultState<ResponseData<Nothing>>> = flow {
        try {
            emit(ResultState.Loading)
            val responseData = ApiHelper.uploadImages(uploadImagesRequest)
            if (responseData.status) {
                emit(ResultState.Success(responseData))
            } else {
                emit(ResultState.Error(Exception(responseData.message)))
            }
        } catch (ex: Exception) {
            emit(ResultState.Error(ex))
        }
    }.flowOn(Dispatchers.IO)


    suspend fun addSenderOrDeliver(
        baseRequest: BaseRequest
    ): Flow<ResultState<ResponseData<Any>>> = flow {
        try {
            emit(ResultState.Loading)
            val responseData = ApiHelper.addSenderOrDeliver(baseRequest)
            if (responseData.status) {
                emit(ResultState.Success(responseData))
            } else {
                emit(ResultState.Error(Exception(responseData.message)))
            }
        } catch (ex: Exception) {
            emit(ResultState.Error(ex))
        }
    }.flowOn(Dispatchers.IO)

}