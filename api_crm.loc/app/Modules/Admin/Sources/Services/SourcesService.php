<?php
namespace App\Modules\Admin\Sources\Services;

use App\Modules\Admin\Sources\Models\Source;
use App\Modules\Admin\Sources\Requests\SourcesRequest;
use Illuminate\Http\Request;

class SourcesService
{
    public function getSources()
    {
        return Source::all();
    }

    public function save(Request $request, Source $source){
        $source->fill($request->only($source->getFillable()));

        $source->save();

        return $source;
    }
}