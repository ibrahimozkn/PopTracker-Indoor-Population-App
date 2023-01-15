<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use App\Models\Business;
use App\Models\PopulationHistory;

class PopulationHistorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $count = Business::get()->count();
        $first = Business::first()->id;
        
        for($i=$first;$i<($count+$first);$i++){
            PopulationHistory::factory()->count(100)->create([
                'business_id' => $i,
            ]);
        }
        
    }
}
