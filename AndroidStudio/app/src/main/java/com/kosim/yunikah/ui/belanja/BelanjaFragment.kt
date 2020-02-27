package com.kosim.yunikah.ui.belanja

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProviders
import com.kosim.yunikah.R

class BelanjaFragment : Fragment() {

    private lateinit var belanjaViewModel: BelanjaViewModel

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        belanjaViewModel =
            ViewModelProviders.of(this).get(BelanjaViewModel::class.java)
        val root = inflater.inflate(R.layout.fragment_belanja, container, false)

        return root
    }
}