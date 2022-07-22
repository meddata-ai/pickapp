package com.psgpw.pickapp.data.network

import okhttp3.OkHttpClient
import okhttp3.internal.tls.OkHostnameVerifier
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

object RetrofitFactory {
    private const val BASE_URL = "https://deckwebtech.com/pickapp_demo/"
    val apiService: ApiService = getRetrofit().create(ApiService::class.java)

    val client: OkHttpClient
        get() {
            val interceptor = HttpLoggingInterceptor()
            interceptor.level = HttpLoggingInterceptor.Level.BODY

            val httpBuilder = OkHttpClient.Builder()
            httpBuilder
                .connectTimeout(15, TimeUnit.SECONDS)
                .readTimeout(20, TimeUnit.SECONDS)
                .addInterceptor(interceptor)  /// show all JSON in logCat
            return httpBuilder.build()
        }

    private fun getRetrofit(): Retrofit = Retrofit.Builder()
        .baseUrl(BASE_URL)
        .client(client)
        .addConverterFactory(GsonConverterFactory.create())
        .build()
}