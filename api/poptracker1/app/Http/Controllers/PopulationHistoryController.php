<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\PopulationHistory;

class PopulationHistoryController extends Controller
{
    public function getPopulationHistory($id){
        $history = PopulationHistory::where('business_id', $id)->get();
        return $history;
    }
}
