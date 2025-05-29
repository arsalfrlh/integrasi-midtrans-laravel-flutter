<?php

use App\Http\Controllers\PaymentApiController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::post('/payment',[PaymentApiController::class,'createPayment']);
Route::post('/payment/bank',[PaymentApiController::class,'paymentBank']);
Route::post('/payment/gopay',[PaymentApiController::class,'paymentGopay']);
Route::post('/payment/status/gopay',[PaymentApiController::class,'statusGopay']);