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
import com.kosim.yunikah.model.Mitra;

import java.util.List;

public class MitraAdapter extends RecyclerView.Adapter<MitraAdapter.ViewHolder> {
    private Context context;
    private List<Mitra> mitraList;

    public MitraAdapter(Context context, List<Mitra> mitraList){
        this.context = context;
        this.mitraList = mitraList;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(context).inflate(R.layout.menu_home_mitra,parent,false);
        return new MitraAdapter.ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        final Mitra mitra = mitraList.get(position);

        holder.txtMitra.setText(mitra.getName());
        holder.txtDeskripsi.setText(mitra.getKeterangan());
        Glide.with(context)
                .load(mitra.getImage().getLink())
                .into(holder.imgMitra);
    }

    @Override
    public int getItemCount() {
        return mitraList.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        private TextView txtMitra,txtDeskripsi;
        private ImageView imgMitra;
        public ViewHolder(@NonNull View itemView) {
            super(itemView);
            txtMitra = itemView.findViewById(R.id.txt_mitra);
            txtDeskripsi = itemView.findViewById(R.id.txt_deskripsi);
            imgMitra = itemView.findViewById(R.id.img_mitra);
        }
    }
}
