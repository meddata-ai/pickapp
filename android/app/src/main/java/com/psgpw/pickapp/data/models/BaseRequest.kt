package com.psgpw.pickapp.data.models

import java.util.*

open class BaseRequest {
    var key: String? = null
    var id: String? = null

    constructor(key: String?, id: String?) {
        this.key = key
        this.id = id
    }
}

class SignInOrSignUpRequest : BaseRequest {
    var name: String? = null
    var email: String? = null
    var password: String? = null
    var confirmPassword: String? = null

    constructor(
        key: String, id: String? = null, name: String? = null,
        email: String,
        password: String? = null,
        confirmPassword: String? = null
    ) : super(key = key, id = id) {
        this.name = name
        this.email = email
        this.password = password
        this.confirmPassword = confirmPassword
    }
}

class EditUserRequest : BaseRequest {
    var name: String? = null
    var phone: String? = null
    var userImage: String? = null
    var apiKey: String? = null

    constructor(
        key: String? = null,
        name: String? = null,
        phone: String? = null,
        userImage: String? = null,
        apiKey: String
    ) : super(key = key, id = null) {
        this.name = name
        this.phone = phone
        this.userImage = userImage
        this.apiKey = apiKey
    }
}


class GetSenderOrDeliverRequest : BaseRequest {
    var date: String? = null
    var departure: String? = null
    var destination: String? = null

    constructor(
        id: String? = null, date: String,
        departure: String,
        destination: String
    ) : super(id = id, key = null) {
        this.date = date
        this.departure = departure
        this.destination = destination
    }
}

class UploadImagesRequest(
    var id: String? = null,
    var comment: String? = null,
    var phone: String? = null,
    var email: String? = null,
    var uploadedFile1: ByteArray? = null,
    var uploadedFile2: ByteArray? = null,
    var uploadedFile3: ByteArray? = null
) {}

class AddSenderOrDeliverRequest : BaseRequest {
    var date: String? = null
    var departure: String? = null
    var destination: String? = null
    var apikey: String? = null
    var fee: String? = null
    var comment: String? = null
    var phone: String? = null
    var email: String? = null
    var viewEmail: Boolean? = null
    var viewPhone: Boolean? = null

    constructor(
        id: String? = null,
        date: String,
        departure: String,
        destination: String,
        apikey: String,
        fee: String,
        comment: String,
        phone: String,
        email: String,
        viewEmail: Boolean,
        viewPhone: Boolean

    ) : super(id = id, key = null) {
        this.date = date
        this.departure = departure
        this.destination = destination
        this.apikey = apikey
        this.fee = fee
        this.comment = comment
        this.phone = phone
        this.email = email
        this.viewEmail = viewEmail
        this.viewPhone = viewPhone
    }
}

