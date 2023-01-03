<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Population;
use App\Models\Business;

class BusinessController extends Controller
{
    public function addBusiness(Request $request)
    {

        $fields = $request->validate([
            'name' => 'required|string',
            'address' => 'required|string',
            'coordinates' => 'required|string'
        ]);

        $population = new Population;
        $population->save();

        $business = new Business;
        $business->name = $fields['name'];
        $business->address = $fields['address'];
        $business->coordinates = $fields['coordinates'];
        $business->population_id = $population->id;
        $business->save();

        return 1;
    }

    public function deleteBusiness($id){

        $business = Business::find($id);
        $population_id = $business->population_id;
        Population::find($population_id)->delete();
        $business->delete();

        return 1;
    }

    public function getBusinesses(){

        return Business::get();
    }
}
