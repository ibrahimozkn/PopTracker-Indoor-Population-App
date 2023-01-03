<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Business extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'address',
        'coordinates',
        'population_id'
    ];

    public $timestamps = false;

    public function population(){
        return $this->belongsTo(Population::class, 'population_id', 'id');
    }

    public function populationHistory(){
        return $this->hasMany(PopulationHistory::class);
    }

}
