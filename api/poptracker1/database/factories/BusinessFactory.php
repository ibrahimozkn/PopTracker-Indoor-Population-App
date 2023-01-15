<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class BusinessFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'name' => $this->faker->company,
            'address' => $this->faker->address,
            'coordinates' => $this->faker->latitude($min = -90, $max = 90).','.$this->faker->longitude($min = -180, $max = 180),
        ];
    }
}
