<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;
use App\Models\Population;
use App\Models\Business;
use App\Models\PopulationHistory;

class Kernel extends ConsoleKernel
{
    /**
     * Define the application's command schedule.
     *
     * @param  \Illuminate\Console\Scheduling\Schedule  $schedule
     * @return void
     */
    protected function schedule(Schedule $schedule)
    {
        $schedule->call(function () {
            $businesses = Business::get();
            foreach($businesses as $business){
                $id = $business->id;
                $population = $business->population()->get('count');
                $date = now()->format('d/m/Y');
                $populationHistory = new PopulationHistory;
                $populationHistory->business_id = $id;
                $populationHistory->population = $population;
                $populationHistory->date = $date;
                $populationHistory->save();
            }
        })->daily();
    }

    /**
     * Register the commands for the application.
     *
     * @return void
     */
    protected function commands()
    {
        $this->load(__DIR__.'/Commands');

        require base_path('routes/console.php');
    }
}
