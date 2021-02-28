<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

use Illuminate\Http\UploadedFile;

class Asset extends Model
{
    protected $guarded = ['id'];
    protected $appends = ['link'];

    public static function createNewFile(UploadedFile $file, Array $attribute = [], $path = null, $disk = 'public') {
    	return static::create(array_merge([
    		'name' => $file->disk($disk)->storeAs(
    			$path ?? 'assets',
    			\Str::random(40) . '.' . $file->getClientOriginalExtension()
    		)
    	], $attribute));
    }

    public function getLinkAttribute()
    {
    	return asset('assets/images/' . $this->name);
    }
}
