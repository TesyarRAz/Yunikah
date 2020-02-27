package com.kosim.yunikah.network;

import com.kosim.yunikah.model.Iklan;
import com.kosim.yunikah.model.Kategori;
import com.kosim.yunikah.model.Mitra;
import com.kosim.yunikah.model.Paket;
import com.kosim.yunikah.model.User;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.Field;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.Path;

public interface ApiInterface {
    @POST("auth/login")
    @FormUrlEncoded
    public Call<User> actionLogin(
            @Field("username") String username,
            @Field("password") String password
    );

    @GET("iklan")
    public Call<List<Iklan>> actionAllIklan();

    @GET("paket")
    public Call<List<Paket>> actionAllPaket();

    @GET("mitra")
    public Call<List<Mitra>> actionAllMitra();

    @GET("kategori/{name}")
    public Call<List<Kategori>> actionAllKategori(@Path("name") String kategori);

}
