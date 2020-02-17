package com.kosim.yunikah.data.model

import com.google.gson.annotations.SerializedName

data class Paket(
        @SerializedName("id")
        var id: Int?,
        @SerializedName("image")
        var image:Asset?,
        @SerializedName("name")
        var name:String?,
        @SerializedName("harga")
        var harga:Int?
)