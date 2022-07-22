package com.psgpw.pickapp.data.network

import android.net.Uri
import android.util.Log
import androidx.core.net.toFile
import androidx.documentfile.provider.DocumentFile
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.psgpw.pickapp.data.models.*
import com.psgpw.pickapp.domain.ResponseData
import com.psgpw.pickapp.domain.ResultState
import okhttp3.MediaType
import okhttp3.RequestBody

import okhttp3.MultipartBody
import java.io.File


object ApiHelper {

    // companion object {

    suspend fun getSignInUser(baseRequest: BaseRequest): ResponseData<User> {
        return RetrofitFactory.apiService.signIn(objectToHashMap(baseRequest))
    }

    suspend fun registerUser(baseRequest: BaseRequest): ResponseData<User> {
        return RetrofitFactory.apiService.registerUser(objectToHashMap(baseRequest))
    }

    suspend fun socialLogin(baseRequest: BaseRequest) {
        RetrofitFactory.apiService.signIn(objectToHashMap(baseRequest))
    }

    suspend fun forgotPassword(baseRequest: BaseRequest) {
        RetrofitFactory.apiService.signIn(objectToHashMap(baseRequest))
    }

    suspend fun addSenderOrDeliver(baseRequest: BaseRequest): ResponseData<Any> {
        return RetrofitFactory.apiService.addSenderOrDeliver(objectToHashMap(baseRequest))
    }

    suspend fun getSenderOrDeliver(baseRequest: BaseRequest): ResponseData<List<SenderOrDeliver>> {
        return RetrofitFactory.apiService.getSenderOrDeliver(objectToHashMap(baseRequest))
    }

    suspend fun editUser(baseRequest: BaseRequest): ResponseData<Nothing> {
        return RetrofitFactory.apiService.editUser(objectToHashMap(baseRequest))
    }

    suspend fun editUserImage(uri: ByteArray, apiKey: String): ResponseData<User> {
        // val file = File(uri.path)
        val requestFile: RequestBody = RequestBody.create(
            MediaType.parse("multipart/form-data"), uri
        )

        val body = MultipartBody.Part.createFormData("userImage", "user_profile", requestFile)

        val key = RequestBody.create(MultipartBody.FORM, KEY_EDIT_IMAGE)

        val apiKey = RequestBody.create(MultipartBody.FORM, apiKey)

        return RetrofitFactory.apiService.editUserImage(key, apiKey, body)
    }


    suspend fun uploadImages(uploadImagesRequest: UploadImagesRequest): ResponseData<Nothing> {
        // val file = File(uri.path)
        var file1: MultipartBody.Part? = null
        var file2: MultipartBody.Part? = null
        var file3: MultipartBody.Part? = null
        if (uploadImagesRequest.uploadedFile1 != null) {
            val requestFile1: RequestBody = RequestBody.create(
                MediaType.parse("multipart/form-data"), uploadImagesRequest.uploadedFile1!!
            )
            file1 = MultipartBody.Part.createFormData("uploadedFile1", "file1", requestFile1)
        }
        if (uploadImagesRequest.uploadedFile2 != null) {
            val requestFile2: RequestBody = RequestBody.create(
                MediaType.parse("multipart/form-data"), uploadImagesRequest.uploadedFile2!!
            )
            file2 = MultipartBody.Part.createFormData("uploadedFile2", "file2", requestFile2)
        }
        if (uploadImagesRequest.uploadedFile3 != null) {
            val requestFile3: RequestBody = RequestBody.create(
                MediaType.parse("multipart/form-data"), uploadImagesRequest.uploadedFile3!!
            )
            file3 = MultipartBody.Part.createFormData("uploadedFile3", "file3", requestFile3)
        }

        val id = RequestBody.create(MultipartBody.FORM, uploadImagesRequest.id!!)

        val comment = RequestBody.create(MultipartBody.FORM, uploadImagesRequest.comment!!)

        val phone = RequestBody.create(MultipartBody.FORM, uploadImagesRequest.phone!!)

        val email = RequestBody.create(MultipartBody.FORM, uploadImagesRequest.email!!)

        return RetrofitFactory.apiService.uploadContactUsImages(
            id = id,
            comment = comment,
            phone = phone,
            email = email,
            file1 = file1,
            file2 = file2,
            file3 = file3
        )
    }

    //  }

    private fun objectToHashMap(baseRequest: BaseRequest): Map<String, String?> {
        val gson: Gson = Gson()
        return gson.fromJson<Map<String, String?>>(
            gson.toJson(baseRequest),
            object : TypeToken<Map<String, String?>>() {}.type
        )
    }


}