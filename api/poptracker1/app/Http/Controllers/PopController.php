<?php

namespace App\Http\Controllers;

use App\Models\Population;
use Illuminate\Http\Request;

class PopController extends Controller
{

    public function addBusiness($id)
    {
        $population = new Population;
        $population->id= $id;
        $population->count= 0;
        $population->save();
        return 1;
    }

    public function getCurrentPopulation($id)
    {
        $result = Population::where('id', $id)->get('count');
        return $result;
    }

    public function IncrementPopulation($id)
    {
        $result = Population::find($id);
        $result->count++;
        $result->save();
        return 1;
    }

    public function DecrementPopulation($id)
    {
        $result = Population::find($id);
        $result->count--;
        if($result->count < 0){
            return 0;
        }
        $result->save();
        return 1;
    }
}
