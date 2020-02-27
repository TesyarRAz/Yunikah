package com.kosim.yunikah.model

import com.google.gson.annotations.SerializedName

data class Paket(
    @SerializedName("id")
    val id : Int?,
    @SerializedName("name")
    val name : String?,
    @SerializedName("image")
    val image : Asset?
) : Response()