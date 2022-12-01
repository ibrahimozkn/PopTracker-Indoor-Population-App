<?php

use App\Http\Controllers\PopController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::get('/population/{id}', [PopController::class, 'getCurrentPopulation']);
Route::post('/population/add/{id}', [PopController::class, 'IncrementPopulation']);
Route::post('/population/remove/{id}', [PopController::class, 'DecrementPopulation']);

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
