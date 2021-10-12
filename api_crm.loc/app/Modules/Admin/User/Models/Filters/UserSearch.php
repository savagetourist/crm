<?php

namespace App\Modules\Admin\User\Models\Filters;

use App\Modules\Admin\User\Models\User;
use App\Services\Filters\BaseSearch;
use App\Services\Filters\Searchable;

Class UserSearch  implements Searchable
{
    const MODEL = User::class;
    use BaseSearch;
}