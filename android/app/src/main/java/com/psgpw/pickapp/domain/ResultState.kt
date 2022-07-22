package com.psgpw.pickapp.domain
sealed class ResultState<out R> {
    data class Success<out T>(val data: T) : ResultState<T>()
    data class Error(val exception: Exception) : ResultState<Nothing>()
    object Loading : ResultState<Nothing>()
}

class ResponseData<T>( val data : T, val status : Boolean, val message : String)