package com.kosim.yunikah.model

import com.google.gson.annotations.SerializedName

data class Iklan(
    @SerializedName("id")
    var id : Int?,
    @SerializedName("name")
    var name: String?,
    @SerializedName("keterangan")
    var keterangan: String?,
    @SerializedName("image")
    var image : Asset?

) : Response()