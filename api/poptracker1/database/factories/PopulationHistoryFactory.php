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
            'population' => $this->faker->numberBetween($min = 0, $max = 50),
            'date' => $this->faker->unique()->dateTimeInInterval('-24 week', '+168 days')->format('Y-m-d'),
        ];
    }
}
