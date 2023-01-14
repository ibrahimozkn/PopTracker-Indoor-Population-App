<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use App\Models\PopulationHistory;
use Illuminate\Support\Facades\DB;

class PopulationHistoryController extends Controller
{
    public function getPopulationHistory($id){
        if(Auth::user()->is_admin != 1){
            return response(['message' => 'Authorization error, account is not Admin!'], 401);
        }

        $history = PopulationHistory::select('population', 'date')->where('business_id', $id)->orderBy('date', 'ASC')->get();

        return $history;
    }
}
