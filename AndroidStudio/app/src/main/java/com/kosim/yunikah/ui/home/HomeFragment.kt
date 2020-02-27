package com.faz.yunikah.ui.home

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.bumptech.glide.Glide
import com.kosim.yunikah.R
import com.kosim.yunikah.network.ApiNetwork
import com.kosim.yunikah.ui.home.HomeViewModel
import com.kosim.yunikah.ui.home.adapter.MitraAdapter
import com.kosim.yunikah.ui.home.adapter.PaketAdapter
import com.synnapps.carouselview.CarouselView
import com.synnapps.carouselview.ImageListener

class HomeFragment : Fragment() {

    private var homeViewModel: HomeViewModel? = null
    private var carouselIklan: CarouselView? = null
    private var rcPaket: RecyclerView? = null
    private var rcMitra: RecyclerView? = null

    internal var imageListener: ImageListener =
        ImageListener { position, imageView ->
            Glide.with(this)
                .load(homeViewModel?.listIklan?.value!![position].image?.link)
                .into(imageView)
        }


    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?, savedInstanceState: Bundle?
    ): View? {

        homeViewModel = ViewModelProviders.of(this).get(HomeViewModel::class.java)
        val root = inflater.inflate(R.layout.fragment_home, container, false)

        carouselIklan = root.findViewById(R.id.carouselView)
        rcPaket = root.findViewById(R.id.rc_menu)
        rcMitra = root.findViewById(R.id.rc_mitra)

        rcMitra?.isNestedScrollingEnabled = false

        (root as SwipeRefreshLayout).setOnRefreshListener {
            Thread {
                val iklans = ApiNetwork.getApiInterface().actionAllIklan().execute().body()
                val pakets = ApiNetwork.getApiInterface().actionAllPaket().execute().body()
                val mitras = ApiNetwork.getApiInterface().actionAllMitra().execute().body()

                activity?.runOnUiThread {
                    homeViewModel?.listIklan?.value = iklans
                    homeViewModel?.listPaket?.value = pakets
                    homeViewModel?.listMitra?.value = mitras

                    root.isRefreshing = false
                }
            }.start()
        }

        homeViewModel?.listIklan?.observe(this, Observer {
            carouselIklan?.pageCount = it.size
            carouselIklan?.setImageListener(imageListener)
        })

        homeViewModel?.listPaket?.observe(this, Observer {
            val paketAdapter = PaketAdapter(activity, it)
            rcPaket?.adapter = paketAdapter
        })

        homeViewModel?.listMitra?.observe(this, Observer {
            val mitraAdapter = MitraAdapter(activity, it)
            rcMitra?.adapter = mitraAdapter
        })

        return root
    }
}
