<?php

namespace App\Http\Controllers;

use App\Models\Population;
use App\Models\Business;
use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\ModelNotFoundException;

class PopController extends Controller
{

    public function getCurrentPopulation($id)
    {
        try{
            return Business::findOrFail($id)->population()->get('count');
        }
        catch(ModelNotFoundException $err){
            return $err;
        }
    }

    public function IncrementPopulation($id)
    {
        $result = Business::findOrFail($id)->population()->get()->first();
        $result->count++;
        $result->save();
        return 1;
    }

    public function DecrementPopulation($id)
    {
        $result = Business::findOrFail($id)->population()->get()->first();
        $result->count--;
        if($result->count < 0){
            return 0;
        }
        $result->save();
        return 1;
    }
}
