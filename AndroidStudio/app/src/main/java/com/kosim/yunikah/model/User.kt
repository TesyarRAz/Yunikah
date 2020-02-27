package com.kosim.yunikah.model

import com.google.gson.annotations.SerializedName

/**
 * Data class that captures user information for logged in users retrieved from LoginRepository
 */
class User (
    @SerializedName("id")
    var id : Int?,
    @SerializedName("name")
    var name : String?,
    @SerializedName("telp")
    var telp : String?,
    @SerializedName("username")
    var username : String?,
    @SerializedName("password")
    var password : String?,
    @SerializedName("alamat")
    var alamat : String?,

    var token : String?
) : Response() {
    fun getAuthorizationToken() = "Bearer $token"
}