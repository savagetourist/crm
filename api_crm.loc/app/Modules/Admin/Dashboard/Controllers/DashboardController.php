<?php

namespace App\Modules\Admin\Dashboard\Controllers;

use Illuminate\Http\Request;
use App\Modules\Admin\Dashboard\Classes\Base;

class DashboardController extends Base
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $this->title = __("admin.dashboard_title_page");
        $this->content = view('Admin::Dashboard.index')->with([
            'title' => $this->title
        ])->render();

        return $this->renderOutput();
    }

}
