package com.kosim.yunikah.ui.home.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.bumptech.glide.Glide;
import com.kosim.yunikah.R;
import com.kosim.yunikah.model.Paket;

import java.util.List;

public class PaketAdapter extends RecyclerView.Adapter<PaketAdapter.ViewHolder> {
    private Context context;
    private List<Paket> paketList;

    public PaketAdapter(Context context, List<Paket> paketList) {
        this.context = context;
        this.paketList = paketList;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(context).inflate(R.layout.menu_home_aksi, parent,false);
        return new PaketAdapter.ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull PaketAdapter.ViewHolder holder, int position) {
        final Paket paket = paketList.get(position);
        holder.txtPaket.setText(paket.getName());

        Glide.with(context)
                .load(paket.getImage().getLink())
                .into(holder.imgPaket);
    }

    @Override
    public int getItemCount() {
        return paketList.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        private ImageView imgPaket;
        private TextView txtPaket;

        public ViewHolder(@NonNull View itemView) {
            super(itemView);
            imgPaket = itemView.findViewById(R.id.img_paket);
            txtPaket = itemView.findViewById(R.id.txt_paket);
        }
    }
}
