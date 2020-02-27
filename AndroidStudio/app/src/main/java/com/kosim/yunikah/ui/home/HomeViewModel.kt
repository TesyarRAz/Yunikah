package com.kosim.yunikah.ui.home

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.kosim.yunikah.model.Iklan
import com.kosim.yunikah.model.Mitra
import com.kosim.yunikah.model.Paket

class HomeViewModel : ViewModel() {
    val listIklan = MutableLiveData<List<Iklan>>()
    val listPaket = MutableLiveData<List<Paket>>()
    val listMitra = MutableLiveData<List<Mitra>>()
}