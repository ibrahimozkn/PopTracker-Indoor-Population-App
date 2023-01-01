<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PopulationHistory extends Model
{
    use HasFactory;

    private $fillable = [
        'population',
        'date'
    ];
}
