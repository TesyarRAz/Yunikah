package com.kosim.yunikah.data.model;

import com.google.gson.annotations.SerializedName;

import retrofit2.http.Field;

public class Iklan {
    @SerializedName("id")
    private int id;
    @SerializedName("image")
    private Asset image;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Asset getImage() {
        return image;
    }

    public void setImage(Asset image) {
        this.image = image;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getKeterangan() {
        return keterangan;
    }

    public void setKeterangan(String keterangan) {
        this.keterangan = keterangan;
    }

    @SerializedName("name")
    private String name;
    @SerializedName("keterangan")
    private String keterangan;


}
