<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use App\Models\Business;
use App\Models\Population;

class BusinessSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        for ($i = 0; $i < 50; $i++) {
            $population = new Population;
            $population->save();
            Business::factory()->create([
                'population_id' => $population->id,
            ]);
        }
        
    }
}
