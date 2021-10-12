<?php
namespace App\Modules\Admin\Status\Controllers\Api;

use App\Modules\Admin\Status\Models\Status;
use App\Services\Response\ResponseService;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class StatusesController extends Controller
{

    public function index()
    {
        $statuses = Status::all();

        //send response
        return ResponseService::sendJsonResponse(true, 200, [], [
            'items' => $statuses->toArray()
        ]);
    }
}