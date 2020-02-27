package com.kosim.yunikah.model

import com.google.gson.annotations.SerializedName

data class StatusKategori (
    @SerializedName("id")
    var id: Int?,
    @SerializedName("keterangan")
    var keterangan: String?
) : Response()

data class Kategori(
    @SerializedName("id")
    var id : Int?,
    @SerializedName("name")
    var name : String?,
    @SerializedName("harga")
    var harga: Int?,
    @SerializedName("image")
    var image: Asset?

) : Response()