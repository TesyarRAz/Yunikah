<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ProdukRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'name' => 'required',
            'harga' => 'numeric',
            'image' => 'file|image',
            'kategori_id' => 'required|exists:kategoris,id',
            'type' => 'required|in:tersedia,custom,combo'
        ];
    }
}
