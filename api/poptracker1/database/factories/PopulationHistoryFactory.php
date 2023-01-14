<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class PopulationHistoryFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'business_id' => 1,
            'population' => $this->faker->numberBetween($min = 0, $max = 50),
            //'date' => $this->faker->date($format = 'd/m/Y', $min = '-1 years', $max = 'now'),
            'date' => $this->faker->dateTimeInInterval('-1 week', '+7 days')->format('d/m/Y'),
        ];
    }
}
