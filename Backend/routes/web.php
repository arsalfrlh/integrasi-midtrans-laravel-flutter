<?php

use App\Http\Controllers\PaymentController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/index',[PaymentController::class,'index']);
Route::post('/payment',[PaymentController::class,'createPayment']);
Route::get('/payment/bank',[PaymentController::class,'createBank']);
Route::post('/payment/bank/proses',[PaymentController::class,'paymentBank']);
Route::get('/payment/gopay',[PaymentController::class,'createGopay']);
Route::post('/payment/gopay/proses',[PaymentController::class,'paymentGopay']);
Route::get('/payment/cstore',[PaymentController::class,'createCstore']);
Route::post('/payment/cstore/proses',[PaymentController::class,'paymentCstore']);
