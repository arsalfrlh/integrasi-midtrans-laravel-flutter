<?php

namespace App\Http\Controllers;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Validator;
use Midtrans\Config;
use Midtrans\Snap;

class PaymentApiController extends Controller
{
    public function createPayment(Request $request){
        $validator = Validator::make($request->all(),[
            'name' => 'required',
            'email' => 'required',
            'total' => 'required',
        ]);

        if($validator->fails()){
            return response()->json(['message' => 'Ada kesalahan', 'success' => false, 'data' => $validator->errors()->all()]);
        }

        Config::$serverKey = config('midtrans.server_key');
        Config::$clientKey = config('midtrans.client_key');
        Config::$isProduction = config('midtrans.is_production');
        Config::$isSanitized = config('midtrans.is_3ds');

        $transaksi = [
            'transaction_details' => [
                'order_id' => 'ORDER-'.uniqid(),
                'gross_amount' => $request->total,
            ],
            'customer_details' => [
                'first_name' => $request->name,
                'email' => $request->email,
            ],
        ];

        $snapToken = Snap::getSnapToken($transaksi);
        $data = [
            'snapToken' => $snapToken,
        ];
        return response()->json(['message' => 'Sialahkan lakukan pembayaran', 'success' => true, 'data' => $data]);
    }

    public function paymentBank(Request $request){
        $validator = Validator::make($request->all(),[
            'name' => 'required',
            'email' => 'required',
            'gross_amount' => 'required',
            'bank_transfer' => 'required',
            'payment_type' => 'required',
        ]);

        if($validator->fails()){
            return response()->json(['message' => 'Ada kesalahan', 'success' => false, 'data' => $validator->errors()->all()]);
        }

        $serverKey = config('midtrans.server_key');
        try{
            $response = Http::withBasicAuth($serverKey, '')->post('https://api.sandbox.midtrans.com/v2/charge',[
            'bank_transfer' => [
                'bank' => $request->bank_transfer,
            ],
            'payment_type' => $request->payment_type,
            'transaction_details' => [
                'order_id' => 'ORDER-'.uniqid(),
                'gross_amount' => $request->gross_amount,
            ],
            'customer_details' => [
                'first_name' => $request->name,
                'email' => $request->email,
            ],
            'custom_expiry' => [
            'order_time' => now()->format('Y-m-d H:i:s O'),
            'expiry_duration' => 24,
            'unit' => 'hour'
            ],
        ]);

        $data = $response->json();
            return response()->json(['message' => 'Pembayaran berhasil, segera Lakukan pembayaran', 'success' => true, 'data' => $data]);
        }catch(Exception $e){
            return response()->json(['message' => $e->getMessage(), 'success' => false, 'data' => null]);
        }
    }

    public function paymentGopay(Request $request){
        $validator = Validator::make($request->all(),[
            'name' => 'required',
            'email' => 'required',
            'gross_amount' => 'required',
            'payment_type' => 'required',
        ]);

        if($validator->fails()){
            return response()->json(['message' => 'Ada kesalahan', 'success' => false, 'data' => $validator->errors()->all()]);
        }

        try{
            $serverKey = config('midtrans.server_key');
            $response = Http::withBasicAuth($serverKey, '')->post('https://api.sandbox.midtrans.com/v2/charge',[
                'payment_type' => $request->payment_type,
                'transaction_details' => [
                    'order_id' => 'ORDER-'.uniqid(),
                    'gross_amount' => $request->gross_amount,
                ],
                'customer_details' => [
                    'first_name' => $request->name,
                    'email' => $request->email,
                ],
            ]);

            $data = $response->json();
            return response()->json(['message' => 'Pembayaran berhasil, Segera Lakukan pembayaran', 'success' => true, 'data' => $data]);
        }catch(Exception $e){
            return response()->json(['message' => $e->getMessage(), 'success' => false, 'data' => null]);
        }
    }

    public function statusGopay(Request $request){
        $status = $request->status;
        try{
            $serverKey = config('midtrans.server_key');
            $response = Http::withBasicAuth($serverKey, '')->get($status);

            $data = $response->json();
            return response()->json(['message' => 'Transaksi berhasil ditemukan', 'success' => true, 'data' => $data]);
        }catch(Exception $e){
            return response()->json(['message' => $e->getMessage(), 'success' => false, 'data' => null]);
        }
    }
}
