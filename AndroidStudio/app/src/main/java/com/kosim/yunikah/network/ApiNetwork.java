package com.kosim.yunikah.network;

import java.util.concurrent.TimeUnit;

import okhttp3.OkHttpClient;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class ApiNetwork {
    private static ApiNetwork instance;
    private static ApiInterface apiInterface;

    public static ApiNetwork getInstance() {
        if (instance == null) {
            instance = new ApiNetwork();
        }
        return instance;
    }

    public static ApiInterface getApiInterface() {
        return apiInterface;
    }

    private ApiNetwork() {
        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl("http://192.168.43.14/api/")
                .addConverterFactory(GsonConverterFactory.create())
                .client(new OkHttpClient.Builder()
                    .writeTimeout(1, TimeUnit.MINUTES)
                    .readTimeout(1, TimeUnit.MINUTES)
                    .connectTimeout(1, TimeUnit.MINUTES)
                    .build()
                )
                .build();

        apiInterface = retrofit.create(ApiInterface.class);
    }
}
