<?php

namespace App\Http\Controllers;

use App\Models\Population;
use Illuminate\Http\Request;

class PopController extends Controller
{
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
        $result->save();
        return 1;
    }
}
