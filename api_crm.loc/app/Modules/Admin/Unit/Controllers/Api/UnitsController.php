<?php

namespace App\Modules\Admin\Unit\Controllers\Api;


use App\Http\Controllers\Controller;
use App\Modules\Admin\Unit\Services\UnitsService;
use App\Services\Response\ResponseService;

class UnitsController extends Controller
{

    private $service;

    /**
     * RoleController constructor.
     */
    public function __construct(UnitsService $unitsService)
    {
        $this->service = $unitsService;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //

        return ResponseService::sendJsonResponse(true, 200,[],[
            'items' =>  $this->service->getUnits()
        ]);
    }



}
