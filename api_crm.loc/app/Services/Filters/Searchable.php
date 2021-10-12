<?php

namespace App\Services\Filters;

use Illuminate\Http\Request;

Interface Searchable 
{
    public function apply(Request $request);
}