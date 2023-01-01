<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Business extends Model
{
    use HasFactory;

    private $fillable = [
        'name',
        'address',
        'coordinates'
    ];

    public $timestamps = false;

    public function population(){
        return $this->has(Population::class);
    }

    public function populationHistory(){
        return $this->hasMany(PopulationHistory::class);
    }

}
