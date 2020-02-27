package com.kosim.yunikah.model

import com.google.gson.annotations.SerializedName

data class Mitra(
    @SerializedName("id")
    val id : Int?,
    @SerializedName("name")
    val name : String?,
    @SerializedName("keterangan")
    val keterangan : String?,
    @SerializedName("image")
    val image : Asset?
) : Response()