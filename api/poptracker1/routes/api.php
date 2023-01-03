<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\PopController;
use App\Http\Controllers\BusinessController;
use App\Http\Controllers\PopulationHistoryController;


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

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::get('/business', [BusinessController::class, 'getBusinesses']);
Route::post('/business', [BusinessController::class, 'addBusiness']);
Route::post('/deleteBusiness/{id}', [BusinessController::class, 'deleteBusiness']);
Route::get('/population/{id}', [PopController::class, 'getCurrentPopulation']);
Route::get('/history/{id}', [PopulationHistoryController::class, 'getPopulationHistory']);
Route::post('/population/add/{id}', [PopController::class, 'IncrementPopulation']);
Route::post('/population/remove/{id}', [PopController::class, 'DecrementPopulation']);

//Protected Routes (need token to access)
Route::group(['middleware' => ['auth:sanctum']], function () {
    Route::post('/logout', [AuthController::class, 'logout']);
});

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
