package com.psgpw.pickapp.data.network

import com.psgpw.pickapp.data.models.SenderOrDeliver
import com.psgpw.pickapp.data.models.User
import com.psgpw.pickapp.domain.ResponseData
import com.psgpw.pickapp.domain.ResultState
import retrofit2.http.POST
import retrofit2.http.QueryMap
import okhttp3.MultipartBody

import okhttp3.RequestBody

import okhttp3.ResponseBody

import retrofit2.http.Multipart
import retrofit2.http.Part


interface ApiService {

    @POST("signIn.php")
    suspend fun signIn(@QueryMap queries: Map<String, String?>): ResponseData<User>

    @POST("signIn.php")
    suspend fun registerUser(@QueryMap queries: Map<String, String?>): ResponseData<User>

    @POST("editUser.php")
    suspend fun editUser(@QueryMap queries: Map<String, String?>): ResponseData<Nothing>

    @Multipart
    @POST("editUser.php")
    suspend fun editUserImage(
        @Part("key") key: RequestBody,
        @Part("apiKey") apiKey: RequestBody,
        @Part file: MultipartBody.Part?
    ): ResponseData<User>

    @Multipart
    @POST("image.php")
    suspend fun uploadContactUsImages(
        @Part("id") id: RequestBody,
        @Part("comment") comment: RequestBody,
        @Part("phone") phone: RequestBody,
        @Part("email") email: RequestBody,
        @Part file1: MultipartBody.Part?,
        @Part file2: MultipartBody.Part?,
        @Part file3: MultipartBody.Part?
    ): ResponseData<Nothing>

    @POST("addingData.php")
    suspend fun addSenderOrDeliver(@QueryMap queries: Map<String, String?>): ResponseData<Any>

    @POST("getData.php")
    suspend fun getSenderOrDeliver(@QueryMap queries: Map<String, String?>): ResponseData<List<SenderOrDeliver>>
}