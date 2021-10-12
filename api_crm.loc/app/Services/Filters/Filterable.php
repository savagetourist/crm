<?php

namespace App\Services\filters;

use Illuminate\Database\Eloquent\Builder;

interface Filterable
{
    public static function apply(Builder $builder, $value);
}