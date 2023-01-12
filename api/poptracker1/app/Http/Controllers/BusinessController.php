<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use App\Models\Population;
use App\Models\Business;

class BusinessController extends Controller
{
    public function addBusiness(Request $request)
    {

        if(Auth::user()->is_admin != 1){
            return response(['message' => 'Authorization error, account is not Admin!'], 401);
        }
        else{
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
        
    }

    public function deleteBusiness($id){

        if(Auth::user()->is_admin != 1){
            return response(['message' => 'Authorization error, account is not Admin!'], 401);
        }

        $business = Business::find($id);
        $population_id = $business->population_id;
        Population::find($population_id)->delete();
        $business->delete();

        return 1;
    }

    public function editBusiness(Request $request){
        if(Auth::user()->is_admin != 1){
            return response(['message' => 'Authorization error, account is not Admin!'], 401);
        }

        $business = Business::find($request->id);
        if($request->has('name')){
            $business->name = $request->name;
            $business->save();
        }
        if($request->has('address')){
            $business->address = $request->address;
            $business->save();
        }
        if($request->has('coordinates')){
            $business->coordinates = $request->coordinates;
            $business->save();
        }

        return response(['message' => 'Success'], 200);
    }

    public function getBusinesses(){

        return Business::get();
    }
}
